s.boot;
(
SynthDef(\s1,
	{
		arg grain,pitch_shift_ratio,pitch_dispersion,time_dispersio;
		time_dispersio=0.5;
		pitch_dispersion=0.5;
		pitch_shift_ratio=0.5;
		grain=0.5;
		Out.ar(0,PitchShift.ar(
        SoundIn.ar([0, 1]),
        grain,
        pitch_shift_ratio, // pitch shift ratio
        pitch_dispersion,             // pitch dispersion
        time_dispersio    // time dispersion
		))
	}).add
)

NetAddr("127.0.0.1", 57120);

(
var synth;
synth = Synth(\s1,[\grain,0.8,\pitch_shift_ratio,0.1,\pitch_dispersion,0.1,\time_dispersio,0.1]);
OSCdef('OSCreveiver',{
	arg msg;
	x=msg[1];
	y=msg[2];
	z=msg[3];
	q=msg[4];

	postln("x:"+ x+ "y:" +y+"z:"+z+"q:"+q);

	synth.set(\grain, x,\pitchShiftRatio, y,\pitchDispersion, z,\timeDispersion, q);
},
"/pos");
)



