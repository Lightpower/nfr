FIL.core = {
  width: 20,
  height: 20,
  colorCount: 7,
  field: undefined,
  playerBases: undefined,
  moveArea: undefined,
  // Field is [X][Y] array which contains color of point and its owner
  turns: 0,

  start: function(_width, _height, _colorCount, _playerCount, fieldUnityLevel) {
    var i, j,
        playerPoints = [[0,0], [_width-1, _height-1], [_width-1, 0], [0, _height-1]];
    this.width = _width;
    this.height = _height;
    this.colorCount = _colorCount;
    // Init field array
    this.field = new Array(_width);
    for(i=0; i<_width; i++) {
      this.field[i] = new Array(_height);
      for(j=0; j<_height; j++) {
        // undefined color, undefined owner
        this.field[i][j] = [undefined, undefined]
      }
    }
    // Players' base points
    this.playerBases = new Array(_playerCount);
    for(i=0; i<_playerCount; i++) {
      this.playerBases[i] = playerPoints[i];
    }

    this.moveArea = undefined;
    this.turns = 0;

    this.fieldRandom(fieldUnityLevel);
  },

  // unityLevel defines the frequency of color unions on the field. Bigger unityLevel is bigger chance of big color unions
  fieldRandom: function(unityLevel) {
    var x = 0, y = 0,
        unityTry;
    for(; y<this.height; y++) {
      for(; x<this.width; x++)
      {
        for(unityTry = 0; unityTry<unityLevel; unityTry++) {
          this.field[x][y] = [Math.floor(Math.random() * this.colorCount), undefined];
          if(( (x != 0) && (this.field[x][y] == this.field[x-1][y]) ) || ( (y != 0) && (this.field[x][y] == this.field[x][y-1]) )) break;
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
        (shifts[i][1] >= 0)
          && !this.moveArea[ shifts[i][0] ][ shifts[i][1] ]
          && (!!this.field[ shifts[i][0] ][ shifts[i][1] ] [1] || (this.field[ shifts[i][0] ][ shifts[i][1] ] [1] == playerNumber))
          && ((newColor == this.field[ shifts[i][0] ][ shifts[i][1] ] [0]) || (oldColor == this.field[ shifts[i][0] ][ shifts[i][1] ] [0]))
        )
        paintedCellNumber += this.move(playerNumber, shifts[i], newColor, doPaint);
    }

    return paintedCellNumber;
  }
}