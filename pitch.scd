//PitchShift documentation available at:
//https://doc.sccode.org/Classes/PitchShift.html

//FreeReverb documentation available at:
//https://doc.sccode.org/Classes/FreeVerb.html

/*
fn = f0 * (a)^n

f0 = frequency of one fixed note which must be defined. A common choice is setting the A above middle C (A4) at f0 = 440 Hz.

n = the number of half steps away from the fixed note you are.
If you are at a higher note, n is positive. If you are on a lower note, n is negative.

fn = the frequency of the note n half steps away.

a = (2)^1/12 = the twelth root of 2
*/

s.boot;

(
SynthDef(\harmonizer,
	{
		arg grain,fst_h,snd_h,trd_h,pitch_dispersion,time_dispersio,a,amp,n_of_harm,
		r_mix, r_room, r_damp, r_amp;
		var s_in,s_out,har,rev;

		a = (2**(1/12));
		time_dispersio=0.01;
		pitch_dispersion=0.0;
		amp = 6;
		n_of_harm = 3;

		r_mix = 0.5;
		r_room = 0.8;
		r_damp = 0.6;
		r_amp = 0.6;

		fst_h = 12; // one octave up
		snd_h = 4; // use 3 for minor, 4 for major
		trd_h = 7; // use 7 for perfect, 8 for aug, 6 for dim

		grain = 0.4;

		s_in = SoundIn.ar([0, 1], amp, 0); //take the input from soundcard

		s_out =
		FreeVerb.ar(
			(
		PitchShift.ar(s_in, // compute the 1st harmonic
        grain,
		((a**(fst_h))), // pitch shift ratio
        pitch_dispersion, // pitch dispersion
        time_dispersio, // time dispersion
		(amp/n_of_harm) //amp
		)

		+

		PitchShift.ar(s_in, // compute the 2nd harmonic
        grain,
		((a**(snd_h))), // pitch shift ratio
        pitch_dispersion, // pitch dispersion
        time_dispersio, // time dispersion
		(amp/n_of_harm) //amp
		)

		+

		PitchShift.ar(s_in, // compute the 3rd harmonic
        grain,
		((a**(trd_h))), // pitch shift ratio
        pitch_dispersion, // pitch dispersion
        time_dispersio, // time dispersion
		(amp/n_of_harm) //amp
		)
			)	, // input signal
			r_mix, // reverb mix
			r_room, // reverb room
			r_damp, // reverb damp
			r_amp // reverb amp
		);

		Out.ar(0, s_out) // compute the output into the default bus

}).play
)


// to be modified properly:

NetAddr("127.0.0.1", 57120);

(
var synth;
synth = Synth(\harmonizer,[\grain,0.8,\pitchShiftRatio,0.1,\pitchDispersion,0.1,\timeDispersion,0.1,\amp,1,\offset,0.1,\vlas,1,\pan,0]);
OSCdef('OSCreveiver',{
	arg msg;
	x=msg[1];
	y=msg[2];
	z=msg[3];
	q=msg[4];
	p=msg[5];
	s=msg[6];
	e=msg[7];
	r=msg[8];

	postln("x:" +x+ "y:" +y+ "z:" +z+ "q:" +q+ "p:" +p+ "s:" +s+ "e:" +e+ "r:" +r);

	synth.set(\grain, x,\pitchShiftRatio, y,\pitchDispersion, z,\timeDispersion, q,\amp,e,\offset,r,\vlas,s,\pan,p);
},
"/pos");
)
