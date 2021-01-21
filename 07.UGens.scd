(
s.meter(2,8).window.alwaysOnTop_(true);
s.scope(2).window.alwaysOnTop_(true);
)


// ====================================================================================================
// 함수의 인자(Arguments)
// ====================================================================================================
f = {| a, b | a + b };
f.(10,20);

f = {| a = 10, b = 20 |  a + b};
f.();
f.(4, 5);
f.(40);
f.(b: 30);


(
a = {| freq = 440 |
	var amp = 0.2
	SinOsc.ar([freq,freq], 0, amp);
}.play;
)

// 전역변수 a 에 저장된 synth 에 set 메서드를 전달하면
a.set(\freq, 880);
a.set(\freq, 550);
a.set(\freq, 1320);
a.set(\freq, rrand(400,2000));

// synth 종료 메서드
a.free;



(
a = {| freq = 440, amp = 0.2 |
	SinOsc.ar([freq,freq], 0, amp);
}.plot;
)

// 전역변수 a 에 저장된 synth 에 set 메서드를 전달하면
a.set(\freq, 880);
a.set(\freq, 550);
a.set(\freq, 1320);
a.set(\freq, rrand(400,2000));
a.set(\amp, 0.4);

// synth 종료 메서드
a.free;


// ====================================================================================================
// Oscillator / LFO
// ====================================================================================================
// Saw
(
{
	var freq = 440;
	Saw.ar([freq,freq], 0.2);
}.plot;
)

(// Pulse
{
	var freq = 440;
	Pulse.ar([freq, freq], SinOsc.kr(1).range(0.1, 0.9), 0.2); // PWM (Pulse Width Modulation)
}.play;
)


// LFSaw, LFPulse, LFTri
{LFPulse.kr(2)}.plot(1);
{LFSaw.kr(2)}.plot(1);
{LFTri.kr(2)}.plot(1);

(// LFSaw
{
	var freq = LFSaw.kr(1).range(440, 880);
	Saw.ar([freq, freq], 0.2);
}.play;
)


(// LFPulse
{
	var freq = LFPulse.kr(1).range(440,880);
	Saw.ar([freq, freq], 0.2);
}.play;
)

(// LFTri
{
	var freq = LFTri.kr(1).range(440, 880);
	Saw.ar([freq, freq], 0.2);
}.play;
)


// ====================================================================================================
// Random
// ====================================================================================================

{LFNoise0.kr(4)}.plot(1);
{LFNoise1.kr(4)}.plot(1);


(// LFNoise0
{
	var freq = LFNoise0.kr(4).range(440, 880);
	Saw.ar([freq, freq], 0.2);
}.play;
)


(// LFNoise1
{
	var freq = LFNoise1.kr(4).range(440, 880);
	Saw.ar([freq, freq], 0.2);
}.play;
)


// ====================================================================================================
// Pan2
// ====================================================================================================

Pan2.ar(SinOsc.ar);

(
{
	Pan2.ar(Saw.ar(440, 0.2), LFNoise0.kr(4));
}.play;
)


(
{
	Pan2.ar(Saw.ar(440, 0.2), LFNoise1.kr(4));
}.play;
)


(
{
	Pan2.ar(Saw.ar(440, 0.2), SinOsc.kr(Line.kr(0.4, 4, 4)));
}.play;
)





























