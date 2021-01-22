
(
SynthDef(\sine, {|freq = 1440,dur = 1, amp = 0.1|
	var sig =  SinOsc.ar(freq, 0, Line.kr(amp, 0.0, dur, doneAction: 2));
	Out.ar(0, [sig,sig]);
}).add;
)

// ====================================================================================
// Quantize Start Timing
// ====================================================================================

(
Pbind(
	\instrument, \sine,
	\freq, 4000,
	\dur, 0.1,
	\delta, 0.125
).play(quant: 1);
)


// Pdef 는 기본적으로 quant: 1 에 해당하는 퀀타이즈, 싱크로 동작한다.
(
Pdef(\sequence1,
	Pbind(
		\instrument, \sine,
		\freq, 4000,
		\dur, 0.1,
		\delta, 0.25
	)
).quant_(4).play;  // quant: 4
)


(// quant: 1
Pdef(\sequence2,
	Pbind(
		\instrument, \sine,
		\freq, 200,
		\dur, 1.0,
		\delta, 0.5
	)
).play;
)


(
Pdef(\sequence3,
	Pbind(
		\instrument, \sine,
		\freq, 400,
		\dur, 1.0,
		\delta, 1.0
	)
).quant_(2).play;
)


// ====================================================================================
// Pattern
// ====================================================================================

(// Pseq 는 순차적인 패턴
Pdef(\sequence1,
	Pbind(
		\instrument, \sine,
		\freq, Pseq([400, 800, 1400, 2000], inf),
		\amp, 0.04,
		\dur, 1.0,
		\delta, 0.25
	)
).play
)

(// Pseq 는 순차적인 패턴
Pdef(\bass,
	Pbind(
		\instrument, \sine,
		\freq, 100,
		\dur, Pseq([0.2,0.07, 0.2],inf),
		\delta, Pseq([0.25, 0.125, 0.125], inf)  // 1 = 1박(4분음표), 0.5 = 8분음표, 0.25, 16분음표
	)
).play
)

(// Pseq 는 순차적인 패턴
Pdef(\chord,
	Pbind(
		\instrument, \sine,
		\freq, Pseq([ [500,700], [600, 1400] ], inf),
		\dur, 4,
		\delta, 2
	)
).play
)

// Prand

(// Pseq 는 순차적인 패턴
Pdef(\sequence1,
	Pbind(
		\instrument, \sine,
		\freq, Prand([400, 800, 1400, 2000, 4000, 8000], inf),
		\amp, 0.04,
		\dur, 1.0,
		\delta, 0.25
	)
).play
)


ListPattern

// Pshuf
(
Pdef(\sequence1,
	Pbind(
		\instrument, \sine,
		\freq, Pshuf([400, 800, 1400, 2000], inf),
		\amp, 0.04,
		\dur, 1.0,
		\delta, 0.25
	)
).play
)

// Ppatlace
(
Pdef(\sequence1,
	Pbind(
		\instrument, \sine,
		\freq, Ppatlace([ Pseq([100, 80, 120, 100],inf) , 200, Pseq([400,500,600,700],inf), 300], inf),
		\amp, 0.04,
		\dur, 1.0,
		\delta, 0.25
	)
).play
)

// Pn
(
Pdef(\sequence1,
	Pbind(
		\instrument, \sine,
		\freq, Pseq( [ Pn(400, 8), Pn(700,8) ], inf),
		\amp, 0.04,
		\dur, 1.0,
		\delta, 0.25
	)
).play
)





