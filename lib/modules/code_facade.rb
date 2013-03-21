# encoding: UTF-8
module CodeFacade

  RESULT = [
      {not_found: 'Код не найден'},
      {repeated:  'Повторное введение кода'},
      {ok:        'Код принят'}
  ]

  ##
  # Get the group of codes and try to pass each of them. Write the log and return total result
  #
  # Params:
  # - params {Hash} - hash with code string and user which sent this code
  #
  # Returns:
  # - {string} - Result
  def input(params)
    res = []
    params[:code_string].split(" ").each do |code|
      res << check_code({code: code, user: params[:user]})
    end

    make_result(res)
  end

  private

  ##
  # Seeking the code in database, check it is new, create a record about its getting and write to log anyway
  #
  # Params:
  # - params {Hash} - hash with code string and user who sent this code
  #
  # Returns
  # - {Symbol} - Code of result (see RESULT)
  #
  def check_code(params)
    result = nil
    code = CodeString.find_by_data params[:code]
    # Found?
    if code.present?
      team_code = TeamCode.where(team: params[:user].team, code: code.code)
      if team_code.blank?

        # Check as found
        TeamCode.create(team: params[:user].team, code: code.code, state: 'found', zone: code.zone)
      else
        result = :repeated
      end
    else
      result = :not_found
    end

    # Add to log
    Log.create(login: user.login, data: params[:code], result: result, team: params[:user].team)

    result
  end

  ##
  # Compose single result by results array
  #
  # Params:
  # - results {Array of String}
  #
  # Returns:
  # - {String} - Single response string
  #
  # Possible responses:
  #   Нет верных кодов         (if no one code is correct)
  #   Верных кодов: 1          (if at least one code is correct)
  #   Повторное введение кодов (if there are no new correct codes but there is at least one old correct code)
  #
  def make_result(results)
    return "Верных кодов: #{results.select{|i| i == :ok}.size}"      if result.include? :ok
    return 'Повторное введение кодов'       if ( !result.include?(:ok)) && (result.include?(:repeat))
    'Нет верных кодов'
  end

end