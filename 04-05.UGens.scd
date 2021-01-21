// 강좌에서 사용된 슈퍼콜라이더 소스 파일들은 다음에서 다운로드 하실 수 있습니다.
// https://github.com/byulparan/sku_xr_supercollider



// 가장 먼저 서버를 부팅하세요!

s // 서버를 저장하고 있는 전역변수 s
// 서버가 저장된 s 전역변수를 이용해서 서버의 여러 기능에 접근 할 수 가 있습니다.

(
s.options.numAudioBusChannels; // 슈콜에서 사용할 수 있 총 오디오 채널의 갯
s.options.numInputBusChannels = 2; // 오디오인터페이스의 인풋에 할당된 오디오 채널 수
s.options.numOutputBusChannels = 8; // 오디오인터페이스의 아웃풋에 할당된 오디오 채널 수
)

s.boot;  // 서버 부팅
// s.quit;   // 서버 종료

(
s.meter(2,8).window.alwaysOnTop_(true);
s.scope(2).window.alwaysOnTop_(true);
s.freqscope.window.alwaysOnTop_(true);
)



{ SinOsc.ar(440, 0, 0.2) }.play;


(
{
	[ SinOsc.ar(440, 0, 0.2), SinOsc.ar(880, 0, 0.2), SinOsc.ar(1320, 0, 0.5), SinOsc.ar(2000, 0, 1.0) ];
}.play
)

// 배열(Array) - 여러 데이터의 묶음
a = [100,200,300,400];
a[3];


// 만약에 UGen(Unit Generator) 의 입력에 배열이 들어오면 그 UGen 의 배열이 만들어 집니다.
SinOsc.ar([440, 880], 0, 0.1)  // [SinOsc.ar(440, 0, 0.1), SinOsc.ar(880, 0, 0.1)]


(
{
	SinOsc.ar([440, 880, 1320, 2000], 0, [0.2, 0.2, 0.5, 1.0]);  //
}.play
)


(// signal plot
{
	SinOsc.ar(440, 0.0, 1.0);
}.plot(1);
)

(
{
	Line.kr(0.4, 0.0, 1.0);
}.plot(1);
)

(
{
	SinOsc.ar(440, 0.0, Line.kr(0.4, 0.0, 1.0))
}.plot(1);
)


(
{
	SinOsc.ar([440,660], 0.0, Line.kr(0.0, 0.4, 4.0))
}.play;
)

// SinOsc - SineWave 를 만들어내는 UGen. freq, phase, mul, add
// Line   - 직선을 만들어내는 UGen. start, end, dur ..... dur 동안 start 에서 end 도 연결되는 직선을 만들어내는 UGen.

// ar - audiorate  : 1초간 샘플링레이트 만큼 연산을 합니다.
// kr - kontrolrate : ar 보다 적은 수의 연산으로 결과를 만들어 냅니다.

// ar 보다 kr 이 CPU 를 더 적게 소모합니다.
// 하지만 우리 귀에 직접 들리는 소리를 발생시키는 UGen 은 반드시 ar 이어야 합니다.





