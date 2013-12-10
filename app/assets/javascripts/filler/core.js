FIL.core = {
  width: 20,
  height: 20,
  colorCount: 7,
  unityLevel: 10,
  // Field is [X][Y] array which contains color of point and its owner
  field: undefined,
  moveArea: undefined,
  turns: 0,

  start: function(width, height, colorCount, unityLevel) {
    var i, j, point;
    this.width = width;
    this.height = height;
    this.colorCount = colorCount;
    // Init field array
    this.field = new Array(width);
    for(i=0; i<width; i++) {
      this.field[i] = new Array(height);
      for(j=0; j<height; j++) {
        // undefined color, undefined owner
        this.field[i][j] = [undefined, undefined]
      }
    }

    this.moveArea = undefined;
    this.turns = 0;

    this.fieldRandom(unityLevel);

    // Hold start areas
    for(i=0; i<4; i++) {
      if(FIL.players.list[i].type != 0) {
        point = FIL.players.list[i].basePoint;
        this.moveArea = undefined;
        FIL.core.move(i, point, FIL.core.field[point[0]][point[1]][0], FIL.core.field[point[0]][point[1]] [0], true);
      }
    }
  },

  // unityLevel defines the frequency of color unions on the field. Bigger unityLevel is bigger chance of big color unions
  fieldRandom: function(unityLevel) {
    var x, y,
        unityTry;
    for(y=0; y<this.height; y++) {
      for(x=0; x<this.width; x++)
      {
        for(unityTry = 0; unityTry<unityLevel; unityTry++) {
          this.field[x][y] = [Math.floor(Math.random() * this.colorCount), undefined];

          if(x + y == 0) // x=0 && y=0
            break;
          if((x != 0) && (this.field[x][y][0] == this.field[x-1][y][0]))
            break;
          if((y != 0) && (this.field[x][y][0] == this.field[x][y-1][0]))
            break;

        }
      }
    }
  },

  move: function(playerNumber, point, oldColor, newColor, doPaint) {
    var i= 0,
        paintedCellNumber = 1,
        shifts = [
          [point[0],   point[1]-1], // up
          [point[0],   point[1]+1], // down
          [point[0]-1, point[1]],   // left
          [point[0]+1, point[1]]    // right
        ];

    // Check if this the first move
    if(!this.moveArea) {
      this.moveArea = new Array(this.width);
      for(; i<this.width; i++) {
        this.moveArea[i] = new Array(this.height);
      }
    }

    // Paint the point
    if(doPaint) {
      this.field[point[0]][point[1]] = [newColor, playerNumber];
    }
    // Mark this point
    this.moveArea[point[0]][point[1]] = 1;


    // Search
    for(i=0; i<4; i++) {
      if(
        ( this.isPointInField(shifts[i]) )
       && !this.moveArea[ shifts[i][0] ][ shifts[i][1] ]
       && (
            ( !this.field[ shifts[i][0] ][ shifts[i][1] ] [1] && (newColor == this.field[ shifts[i][0] ][ shifts[i][1] ] [0]) )
         || (this.field[ shifts[i][0] ][ shifts[i][1] ] [1] == playerNumber)
          )
        )
        paintedCellNumber += this.move(playerNumber, shifts[i], oldColor, newColor, doPaint);
    }

    return paintedCellNumber;
  },
  
  fieldSetup: function(width, height, colorCount, unityLevel) {
    var tmpWidth, tmpHeight, tmpColorCount, tmpLevel;
    try {
      tmpWidth = parseInt(width);
      tmpHeight = parseInt(height);
      tmpColorCount = parseInt(colorCount);
      tmpLevel = parseInt(unityLevel);
      this.width = tmpWidth;
      this.height = tmpHeight;
      this.colorCount = tmpColorCount;
      this.unityLevel = tmpLevel;
    }catch(e) {}
  },

  isPointInField: function(point) {
    return (point[0] >= 0 && point[0] < this.width)
        && (point[1] >= 0 && point[1] < this.height);
  }
}