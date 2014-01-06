# encoding: UTF-8
class MailoutsController < ApplicationController
  load_and_authorize_resource exclude: [:index, :create, :send]

  def index
    @mailouts = Mailout.accessible_by(current_ability).by_date
  end

  def show

  end

  def new

  end

  def create
    # Mass mail delivery for new Game
    if game = Game.find(params[:mailout][:game_id])
      authorize! :mass_send, game

      @mailout = Mailout.new
      @mailout.from = 'support@nfr.kiev.ua'
      @mailout.to = Team.all.map(&:captain).compact.map(&:email).compact.join(',')
      @mailout.subject = "NFR ##{game.number} - новая игра #{game.start_date.strftime('%d.%m.%y')}"
      @mailout.body = render_to_string('mass_mailer/game_annonce', layout: nil, locals: {game: game})
      @mailout.game = game
      if @mailout.save
        message = "Рассылка для игры \"#{game.name}\" создана"
        if params[:mass_send]
          #Resque.enqueque(MassMailsJob, @mailout.id)
          MassMailsJob.perform(@mailout.id)
          #MassMailer.mass_send(@mailout).deliver
          message += ' и отправлена'
        end
        message += '.'

        render action: :show, notice: message
      end
    else
      render action: :new, error: 'Игра не найдена!'
    end
  end

  def edit

  end

  def update

  end

  def send_mailout
    result = {ok: [], error: []}
    mailouts = Mailout.where(id: params[:mailouts][:id])
    mailouts.each do |mailout|
      if can?(:send, mailout)
        Resque.enqueque(MassMailsJob, mailout.id)
        result[:ok] << mailout.id
      else
        result[:error] << mailout.id
      end
    end
    flash_key = result[:error].size > 0 ? :error : :notice
    message = ''
    message += "Отправлены сообщения: #{result[:ok].join(', ')}"               if result[:ok].size > 0
    message += "Нет прав для отправки сообщений: #{result[:error].join(', ')}" if result[:error].size > 0

    render action: :index, flash_key => message
  end


  private


end
