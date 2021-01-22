(// 기본 설정
s.options.numInputBusChannels = 8;
s.options.numOutputBusChannels = 8;
)

s.boot;
s.meter(2,8).window.alwaysOnTop_(true);


// 함수에 play 를 전달하여 소리를 내는 방식은 임시로 아이디어 체크, 실험 등을 할 때 유용하다.
(
{|freq = 1440,dur = 1|
	Pan2.ar(SinOsc.ar(freq, 0, Line.kr(0.2, 0.0, dur, doneAction: 2)), 0.0);
}.play;
)

// =============================================================================
// SynthDef
// =============================================================================

(
SynthDef(\sine, {|freq = 1440,dur = 1|
	var sig =  SinOsc.ar(freq, 0, Line.kr(0.2, 0.0, dur, doneAction: 2));
	Out.ar(0, [sig,sig]);
}).add;
)

Synth(\sine);
Synth(\sine, [freq: 300]);
Synth(\sine, [freq: 600, dur: 8.0]);

// =============================================================================
// Pbind & Pdef
// =============================================================================

(
Pbind(
	\instrument, \sine,   // Synth 설정 - 어떤 synth 를 호출할지 지정
	\freq, 430,
	\delta, 1.0          // 간격
).play;
)

(
Pdef(\sequence1,
   Pbind(
		\instrument, \sine,   // Synth 설정 - 어떤 synth 를 호출할지 지정
		\freq, 220,
		\delta, 1.0          // 간격
	)
).play;
)

(
Pdef(\chord,
   Pbind(
		\instrument, \sine,   // Synth 설정 - 어떤 synth 를 호출할지 지정
		\freq, [400, 800, 1020, 1200],
		\delta, 1.0          // 간격
	)
).play;
)

