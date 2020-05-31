
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
SynthDef(\s1,
	{
		arg s_in,grain,fst_h,snd_h,trd_h,pitch_dispersion,time_dispersio,a,amp,n_of_harm;
		a = (2**(1/12));
		time_dispersio=0.08;
		pitch_dispersion=0.0;
		amp = 1;
		n_of_harm = 3;


		fst_h = -5;
		snd_h = 4; // use 3 for minor, 4 for major
		trd_h = 7; // use 7 for perfect, 8 for aug, 6 for dim

		grain=0.4;

		s_in = SoundIn.ar([0, 1], amp, 0); //take the input from soundcard

		Out.ar(0,

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

		)
	}).play
)

NetAddr("127.0.0.1", 57120);

(
var synth;
synth = Synth(\s1,[\grain,0.8,\pitchShiftRatio,0.1,\pitchDispersion,0.1,\timeDispersion,0.1,\amp,1,\offset,0.1,\vlas,1,\pan,0]);
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