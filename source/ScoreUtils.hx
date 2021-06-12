package;
import flixel.math.FlxMath;
import Options;
class ScoreUtils
{
	public static var gradeArray:Array<String> = ["☆☆☆☆","☆☆☆","☆☆","☆","S+","S","S-","A+","A","A-","B+","B","B-","C+","C","C-","D"];
	public static var ratingStrings = [
		"sick",
		"good",
		"bad",
		"shit",
	];
	public static var ratingWindows = OptionUtils.ratingWindowTypes[OptionUtils.options.ratingWindow];
	public static function GetAccuracyConditions(): Array<Float>{
		return [
      1.0, // Quad star
      .99, // Trip star
      .98, // Doub star
      .96, // Single star
      .94, // S+
      .92, // S
      .89, // S-
      .86, // A+
      .83, // A
      .8, // A-
      .76, // B+
      .72, // B
      .68, // B-
      .64, // C+
      .6, // C
      .55, // C-
    ];
	}
	public static function AccuracyToGrade(accuracy:Float):String {
    var grade = gradeArray[gradeArray.length-1];
    var accuracyConditions:Array<Float>=GetAccuracyConditions();
    for(i in 0...accuracyConditions.length){
      if(accuracy >= accuracyConditions[i]){
        grade = gradeArray[i];
        break;
      }
    }

    return grade;
  }
	public static function DetermineRating(noteDiff:Float){
		var noteDiff = Math.abs(noteDiff);
		for(idx in 0...ratingWindows.length){
			var timing = ratingWindows[idx];
			var string = ratingStrings[idx];
			if(noteDiff<=timing){
				return string;
			}
		}
		return "sick";
	}

	public static function RatingToHit(rating:String):Float{ // TODO: toggleable ms-based system
		var hit:Float = 0;
		switch (rating){
			case 'shit':
				hit = 1-(ratingWindows[0]/Conductor.safeZoneOffset);
			case 'bad':
				hit = 1-(ratingWindows[1]/Conductor.safeZoneOffset);
			case 'good':
				hit = 1-(ratingWindows[2]/Conductor.safeZoneOffset);
			case 'sick':
				hit = 1;
		}
		return hit;
	}
	public static function RatingToScore(rating:String):Int{
		var score = 0;
		switch (rating){
			case 'shit':
				score = 0;
			case 'bad':
				score = 10;
			case 'good':
				score = 100;
			case 'sick':
				score = 350;
		}
		return score;
	}
}
