import flash.events.TimerEvent;
import flash.utils.Timer;
var finalScore:int;
var count:Number = 3;
var myTimer:Timer = new Timer(1000,count);

MovieClip(root).finalScore = finalScore;

myTimer.addEventListener(TimerEvent.TIMER, countdown);
myTimer.start();

function countdown(event:TimerEvent):void {
myText_txt.text = String((count)-myTimer.currentCount);
if(myText_txt.text == "0"){
gotoAndStop('END');
}
}


Game over Screen:
finalScore.text = String(myScore);

stage.addEventListener(MouseEvent.CLICK, restartGame);
function restartGame(e:MouseEvent):void{
gotoAndPlay(1);
stage.removeEventListener(MouseEvent.CLICK, restartGame);
}


Score .as file
package {

import flash.display.MovieClip;
import flash.events.Event;

public class Score extends MovieClip {

private const SPEED:int = 5; 
private const NUM_DIGITS:int = 7;

private var _totalScore:int = 0;
private var _displayScore:int= 0;


public function Score() {

}


public function get totalScore():int {
return _totalScore;
}


public function add(amount:int):void {
_totalScore += amount;
addEventListener(Event.ENTER_FRAME, updateScoreDisplay); 
}


private function updateScoreDisplay(e:Event):void {


_displayScore += SPEED;


if(_displayScore > _totalScore){
_displayScore = _totalScore;
}

var scoreStr:String = String(_displayScore); 


while(scoreStr.length < NUM_DIGITS){
scoreStr = "0" + scoreStr;
}


for (var i:int = 0; i < NUM_DIGITS; i++) {
var num = int(scoreStr.charAt(i));
this["digit"+(i+1)].gotoAndStop(num+1);
}


if(_totalScore == _displayScore){
removeEventListener(Event.ENTER_FRAME, updateScoreDisplay);
}
}

}

}

Game.as File
package {

import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.media.Sound;

public class Game extends MovieClip {


public function Game() {

bumper10.addEventListener(MouseEvent.MOUSE_DOWN, onBumperClick);
bumper25.addEventListener(MouseEvent.MOUSE_DOWN, onBumperClick);
bumper30.addEventListener(MouseEvent.MOUSE_DOWN, onBumperClick);

}


private function onBumperClick(e:MouseEvent):void {
if(e.currentTarget == bumper10){
myScore.add(10);
} else if (e.currentTarget == bumper25){
myScore.add(50);
} else {
myScore.add(30);
}
}

}

}