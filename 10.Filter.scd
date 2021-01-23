(
s.meter.window.alwaysOnTop_(true);
s.freqscope.window.alwaysOnTop_(true);
)


// =========================================================
// Filter
// =========================================================

// WhiteNoise
{ Pan2.ar(WhiteNoise.ar(0.2)) }.play;

// PinkNoise
{ Pan2.ar(PinkNoise.ar(0.2)) }.play;

// BrownNoise
{ Pan2.ar(BrownNoise.ar(0.2)) }.play;


// LPF, RLPF - 기준점(Cutoff) 이하를 통과시키는 필터
(
{
	var sig = WhiteNoise.ar(0.2);
	//sig = LPF.ar(sig, 1400);
	sig = RLPF.ar(sig, 400, MouseY.kr(0.1, 1.0));
	[sig,sig];
}.play;
)

// HPF, RHPF - 기준점(Cutoff) 이상을 통과시키는 필터
(
{
	var sig = WhiteNoise.ar(0.2);
	// sig = HPF.ar(sig, MouseX.kr(100, 4000));
	sig = RHPF.ar(sig, MouseX.kr(40, 4000), MouseY.kr(0.1, 1.0));
	[sig,sig];
}.play;
)

// BPF - 기준점(Cutoff) 부근만 통과시키는 필터
(
{
	var sig = WhiteNoise.ar(0.2);
	sig = BPF.ar(sig,800, MouseY.kr(0.1, 1.0));
	[sig,sig];
}.play;
)

// =========================================================
// Demo Sequence
// =========================================================

(
SynthDef(\saw_bass, {|freq= 220, cutoff = 440, res = 0.4, dur = 1.0 |
	var env = Line.kr(0.2, 0.0, dur, doneAction: 2);
	var sig = Saw.ar(freq, env);
	var noise = WhiteNoise.ar(env*0.4);
	sig = RLPF.ar(sig + noise, cutoff + SinOsc.kr(4).range(-40, 40), res);
	Out.ar(0, [sig,sig]);
}).add;
)

Synth(\saw_bass, [dur: 4.0]);


TempoClock.default.tempo = 2;  // tempo 조절
TempoClock.default.tempo = 116 / 60;


(
Pdef(\bass,
	Pbind(
		\instrument, \saw_bass,
		\freq, Pseq([48, 49, 48, 47, 48, 51, 48, 47], inf).midicps,
		\cutoff, {rrand(200,1400)},
		\res, {rrand(0.1,0.3)},
		\dur, 0.25,
		\delta, 0.25 // 초(sec)가 아니라 박(beat)
	)
).play;
)



// =========================================================
// Envelope
// Env + EnvGen
// =========================================================


Env([0.0, 0.4, 0.0], [0.9, 0.1]).plot
Env([440, 880, 620, 880, 440], [1.0, 1.0, 0.5, 0.5]).plot

// Env객체는 EnvGen 유닛제레이터와 함께 사용!
EnvGen.kr(  Env([0.0, 0.4, 0.0], [0.9, 0.1])  );

Env([0.0, 0.4, 0.4, 0.0], [0.1, 3.0, 0.1]).plot;

(
{
	var freq = EnvGen.kr(Env([440, 880, 620, 880, 440], [1.0, 1.0, 0.5, 0.5]));
	var amp = EnvGen.kr(Env([0.0, 0.4, 0.4, 0.0], [0.1, 3.0, 0.1]), doneAction: 2);
	SinOsc.ar([freq,freq], 0, amp);
}.play;
)



(
SynthDef(\pad, {|freq = 220, dur = 1.0|
	var amp = EnvGen.kr(Env([0.0, 0.1, 0.1, 0.0], [0.1, dur-0.2, 0.1]), doneAction:2);
	var cutoff = EnvGen.kr(Env([400,1400,400], [dur*0.5, dur*0.5]));
	var sig = RLPF.ar(Saw.ar([freq, freq + 2], amp), cutoff, 0.4);
	Out.ar(0, sig);
}).add;
)

Synth(\pad, [dur: 4.0]);

TempoClock.default.tempo = 76/60;

69 // 미디노트 값 69 = 4번째 옥타브의 "라"
69.midicps;
 [48, 55, 64, 71].midicps;

(
Pdef(\pad,
	Pbind(
		\instrument, \pad,
		\freq, Pseq( [  [48, 55, 64, 71],  [45, 55, 57, 72]  ], inf).midicps,
		\dur, 4.0,
		\delta, 4.0
	)
).quant_(4).play;
)

(
Pdef(\bass,
	Pbind(
		\instrument, \saw_bass,
		\freq, Pseq([48, 48, 55, 48, 48, 52, 54, 55], inf).midicps,
		\cutoff, {rrand(400,1400)},
		\res,0.3,
		\dur, 0.25,
		\delta, 0.25 // 초(sec)가 아니라 박(beat)
	)
).quant_(4).play;
)


(
Pdef(\arp,
	Pbind(
		\instrument, \saw_bass,
		\freq, Prand([48, 48, 55, 48, 48, 52, 54, 55], inf).midicps * 2,
		\cutoff, {rrand(1200,1400)},
		\res,0.3,
		\dur, 0.125,
		\delta, 0.125 // 초(sec)가 아니라 박(beat)
	)
).quant_(4).play;
)

(
Pdef(\arp).stop;
Pdef(\bass).stop;
Pdef(\pad).stop;
)















