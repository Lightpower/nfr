MINT.core = {
  predefined: false,
  width: 5,
  height: 5,
  mineCount: 5,
  // Field is [X][Y] array which contains whether it has mine (0=empty, 1=mine), and label
  field: undefined,
  dead: false,
  openCellLeft: 0,

  predefine: function(data) {
    var array = data.split(';'),
        fieldData = array[3].split(',');

    this.predefined = true;
    this.width  = parseInt(array[0]);
    this.height = parseInt(array[1]);
    this.mineCount = parseInt(array[2]);

    this.initFieldArray();
    this.fillPredefined(fieldData);
    this.dead = false;
    this.openCellLeft = this.width * this.height - this.mineCount;
  },
  // Start
  start: function(width, height, mineCount) {
    this.width = width;
    this.height = height;
    this.mineCount = mineCount;
    // Init field array
    this.initFieldArray();
    this.fieldRandom();
    this.dead = false;
    this.openCellLeft = this.width * this.height - this.mineCount;
  },

  // Init field by 0
  initFieldArray: function() {
    this.field = new Array(this.width);
    for(var i=0; i<this.width; i++) {
      this.field[i] = new Array(this.height);
      for(var j=0; j<this.height; j++) {
        this.field[i][j] = 0
      }
    }
  },

  // Init field by 0
  fieldRandom: function() {
    var x, y,
        minesLeft = this.mineCount;

    for(; minesLeft > 0; minesLeft --) {
      x = Math.floor(Math.random() * this.width);
      y = Math.floor(Math.random() * this.height);
      if (this.field[x][y] === 0) {
        this.field[x][y] = 1;
      }else{
        minesLeft ++;
      }
    }
  },

  // Fill the field by custom data
  fillPredefined: function(data) {
    for(var j=0; j<this.height; j++) {
      for(var i=0; i<this.width; i++) {
        this.field[i][j] = ((data[j] & Math.pow(2, i)) > 0) ? 1 : 0;
      }
    }
  },

  // Player's move
  // Point has coordinates ([X][Y])
  move: function(point) {
    if(this.dead) return -1; // Don't move if we already dead

    if(this.field[point[0]][point[1]] === 1) {
      this.dead = true;
      return 9; // Bomb
    }

    var x, y,
      returnNumber = 0;
    for(x = point[0]-1; x<=point[0]+1; x++) {
      for(y = point[1]-1; y<=point[1]+1; y++) {
        if((x >= 0) && (x < this.width) && (y >= 0) && (y < this.height) && (this.field[x][y] === 1))
          returnNumber += 1;
      }
    }
    return returnNumber;
  },

  fieldSetup: function(width, height, mineCount) {
    var tmpWidth, tmpHeight, tmpMineCount;
    try {
      tmpWidth = parseInt(width);
      tmpHeight = parseInt(height);
      tmpMineCount = parseInt(mineCount);
      this.width = tmpWidth;
      this.height = tmpHeight;
      this.mineCount = tmpMineCount;
    }catch(e) {}
  }
}