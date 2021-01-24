// ========================================================================================
// Sample into Buffer
// ========================================================================================

b = Buffer.read(s, "/Users/byul/Desktop/piano.aiff");

b.numChannels; // 1 이면 모노파일이고 2면 스테레오파일
b.numFrames;
b.sampleRate;
b.numFrames / b.sampleRate;  //샘플의 길이(seconds)

b.plot;
b.play;

(// PlayBuf - Buffer 에 있는 오디오데이터를 읽는 UGen
{
	Line.kr(0, 0, 1, doneAction:2);
	PlayBuf.ar(2, b, BufRateScale.kr(b) * 1 , startPos: b.sampleRate * 8, loop: 1 );
}.play;
)

~string = Buffer.read(s, "/Users/byul/Desktop/string.wav");
~string.numChannels;


(// PlayBuf - Buffer 에 있는 오디오데이터를 읽는 UGen
{
	Line.kr(0, 0, 0.5, doneAction:2);
	Pan2.ar(PlayBuf.ar(1, ~string, BufRateScale.kr(~string) * 1 , startPos: ~string.numFrames * 0.3, loop: 1 ));
}.play;
)

// ========================================================================================
// Sample Loaded
// ========================================================================================

~guitar = Buffer.read(s, "/Users/byul/Desktop/guitar.wav");
~kick = Buffer.read(s, "/Users/byul/Desktop/kick.wav");


~guitar.numChannels;
~kick.numChannels;
~guitar.play;
~kick.play;

// ========================================================================================
// Synth Definition
// ========================================================================================

(
SynthDef(\sampler_mono, {|buf = 0, start = 0.0, rate = 1.0, dur = 1.0, cutoff = 800, rq = 1.0, pan = 0.0|
	var line = Line.kr(0,0,dur,doneAction:2);
	var sig = PlayBuf.ar(1, buf, BufRateScale.kr(buf) * rate, startPos: BufFrames.kr(buf) * start);
	sig = RLPF.ar(sig, cutoff,rq);
	Out.ar(0,Pan2.ar(sig, pan));
}).add;
)

(
SynthDef(\sampler_st, {|buf = 0, start = 0.0, rate = 1.0, dur = 1.0, cutoff = 800, rq = 1.0|
	var line = Line.kr(0,0,dur,doneAction:2);
	var sig = PlayBuf.ar(2, buf, BufRateScale.kr(buf) * rate, startPos: BufFrames.kr(buf) * start);
	sig = RLPF.ar(sig, cutoff,rq);
	Out.ar(0,sig);
}).add;
)

Synth(\sampler_st, [buf: ~guitar, dur: 0.5, cutoff: 1400, rq: 0.2, rate: 0.5]);
Synth(\sampler_st, [buf: ~guitar]);

Synth(\sampler_mono, [buf: ~kick]);
Synth(\sampler_mono, [buf: ~string, dur: 2.0, cutoff: 1400]);


// ========================================================================================
// Sequence
// ========================================================================================

(
Pdef(\sample,
	Pbind(
		\instrument, \sampler_st,
		\buf, ~guitar,
		\start, Ppatlace([ 0.5, Prand([0.25, 0.125, 0.0, 0.75],inf), 0.5, Prand([0.25, 0.125, 0.0, 0.75],inf)], inf),
		\rate, 1.0,
		\cutoff, 1400,
		\rq, 0.3,
		\dur, Pxrand([0.25,0.125,0.125],inf)   // \delta 값이 없는 경우에는 \dur 을 \delta 값으로 사용합니다.
	)
).quant_(4).play;
)

(
Pdef(\kick,
	Pbind(
		\instrument, \sampler_mono,
		\buf, ~kick,
		\dur, 0.5
	)
).quant_(4).play;
)


(
SynthDef(\pad, {|freq = 220, dur = 1.0|
	var amp = EnvGen.kr(Env([0.0, 0.2, 0.2, 0.0], [0.1, dur-0.2, 0.1]), doneAction:2);
	var cutoff = EnvGen.kr(Env([400,1400,400], [dur*0.5, dur*0.5]));
	var sig = RLPF.ar(Saw.ar([freq, freq + 2], amp), cutoff, 0.4);
	Out.ar(0, sig);
}).add;
)

(
Pdef(\pad,
	Pbind(
		\instrument, \pad,
		\freq, Prand( [ 71,73,74,78,79], inf).midicps,
		\dur, 4.0,
		\delta, 4.0
	)
).quant_(4).play;
)

(
Pdef(\kick).stop;
Pdef(\pad).stop;
Pdef(\sample).stop;
)







