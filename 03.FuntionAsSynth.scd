// 만약 서버 boot 에 실패했다면?

// 1. ERROR: Input sample rate is 88200, but output is 44100. Mismatched sample rates are not supported. To disable input, set the number of input channels to 0.
// could not initialize audio.
// RESULT = 0
// SuperCollider 는 반드시 인풋과 아웃풋의 샘플링 레이트가 같아야 됩니다.


// 2. Exception in World_OpenUDP: unable to bind udp socket
// This could be because another instance of scsynth is already using it.
// You can use SuperCollider (sclang) to kill all running servers by running `Server.killAll`.
// You can also kill scsynth using a terminal or your operating system's task manager.


{ 10 + 20 }.()

// SinOsc 는 싸인파(Sinewave) 를 발생시키는 UGen.
// SuperCollider 에서 시그널을 발생시키는 오브젝트를 UGen(Unit Generator) 라고 합니다.
{ SinOsc.ar }.play; // == { SinOsc.ar(440.0, 0.0, 1.0, 0.0) }.play;

// 만약에
// 1. 함수의 마지막 라인이 UGen 이고
// 2. play 와 함께 실행한다면 Synth 를 리턴하면서 소리를 발생시킵니다.

{ SinOsc.ar(880,0.0,0.2) }.play;

{ SinOsc.ar(1880,0.0,0.2) }.play;

{ SinOsc.ar(1320, 0.0, 0.2) }.play;


{ [ SinOsc.ar(880, 0, 0.2), SinOsc.ar(660, 0, 0.2), SinOsc.ar(2000, 0, 0.2), SinOsc.ar(1000, 0, 0.2) ] }.play;
{ SinOsc.ar([880, 660, 2000, 1000], 0.0, 0.2) }.play;
