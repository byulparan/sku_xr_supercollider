// OSC(Open Sound Control)

// =============================================================
// OSC send
// =============================================================

NetAddr // 메시지를 보낼 타겟 프로그램의 주소정보를 담고 있는 객체

~max = NetAddr("127.0.0.1", 14000);
~max.sendMsg("/one_two");
~max.sendMsg("/hello_max", 10, 20, 30, 40);
~max.sendMsg("/hello", "world");

~p5 = NetAddr("127.0.0.1", 12000);
~p5.sendMsg("/circle", -100.0, 20.0);


// =============================================================
// OSC receive
// =============================================================

// SCLang 의 OSC 포트넘버는 57120

OSCFunc // 슈퍼콜라이더로 수신되는 메시지를 처리하는 명령어

(
OSCFunc({ | msg |
	msg.postln;
}, "/hello")
)


(
OSCFunc({|msg|

	"/hello_sc".postln;

}, "/hello_sc"
);

OSCFunc({|msg|

	"/goodbye_sc".postln;

}, "/goodbye_sc")
)



// Server to Client

SendReply // 서버에서 Interpreter 로 메시지를 보내는 UGen

(

OSCFunc({|msg|
	//msg.postln;
	~p5.sendMsg("/circle", msg[3] * 200, msg[4] * 800);
}, "/fromServer");

{
	var lfo = SinOsc.kr(0.4);
	var amp = LFSaw.kr(1).range(0, 0.2);


	SendReply.kr(Impulse.kr(30), "/fromServer", [lfo,amp]);

	Pan2.ar(SinOsc.ar(lfo.range(400, 1000), 0, amp));
}.play;

)



// =============================================================
// Effect
// =============================================================

(
SynthDef(\saw_bass, {|freq= 220, osc=0,cutoff = 440, res = 0.4, dur = 1.0, revbus = 0,delbus=0|
	var env = Line.kr(0.2, 0.0, dur, doneAction: 2);
	var sig = Saw.ar(freq, env);
	var noise = WhiteNoise.ar(env*0.4);
	sig = RLPF.ar(sig + noise, cutoff + SinOsc.kr(4).range(-40, 40), res);
	SendReply.kr(Impulse.kr(0.001) * osc, "/saw_bass");
	Out.ar(0, [sig,sig]);
	Out.ar(60, [sig,sig] * revbus);
	Out.ar(62, [sig, sig] * delbus);
}).add;
)

(// Reverb
{
	GVerb.ar(In.ar(60, 2), 100, 6.0);
}.play;
)

(// Delay
{
	CombN.ar(In.ar(62, 2), 4.0, 0.25, 2.0);
}.play;
)


Synth(\saw_bass, [dur:0.2, revbus: 0.2, delbus: 0.4, osc: 0]);

(
OSCFunc({|msg|
	~p5.sendMsg("/drop");
}, "/saw_bass")
)



(
Pdef(\test,
	Pbind(
		\instrument, \saw_bass,
		\freq, Prand([60,67,70,63, 72],inf).midicps,
		\dur, 0.5,
		\osc, 1,
		\revbus, Pseq([0.2, 0.0, 0.0, 0.0],inf),
		\delbus, Pseq([0.0, 0.0, 0.4,0.0],inf),
		\delta, 1
	)
).play;
)

(
Pdef(\bass,
	Pbind(
		\instrument, \saw_bass,
		\freq, 48.midicps,
		\osc, 0,
		\dur, 0.25
	)
).play;
)




(

OSCFunc({ |msg|
	~p5.sendMsg("/circle", 0.0, msg[3] * 400);
}, "/volume"); // /volume 메시지 핸들링

{
	// 100번 버스로 입력되는 시그널을 받아서 그 앰프값을 1초에 30번 /volume 메시지로 클라이언트에 전송
	SendReply.kr(Impulse.kr(30), "/volume", In.ar(100,2).abs);
}.play;
)


(
~kick = Buffer.read(s, "/Users/byul/Desktop/kick.wav");

SynthDef(\sampler_mono, {|buf = 0, start = 0.0, rate = 1.0, dur = 1.0, cutoff = 800, rq = 1.0, pan = 0.0|
	var line = Line.kr(0,0,dur,doneAction:2);
	var sig = PlayBuf.ar(1, buf, BufRateScale.kr(buf) * rate, startPos: BufFrames.kr(buf) * start);
	sig = RLPF.ar(sig, cutoff,rq);
	Out.ar(0,Pan2.ar(sig, pan));
	Out.ar(100,Pan2.ar(sig, pan));  // 100번 버스에 시그널 출력
}).add;
)

(
Pdef(\kick,
	Pbind(
		\instrument, \sampler_mono,
		\buf, ~kick,
		\delta, Pseq([1.5,0.5],inf)
	)
).play;
)















