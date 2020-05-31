
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
{
	arg a, fst_h, snd_h, z;

	a = (2**(1/12));
	fst_h = 4;
	snd_h = 7;

	z = SoundIn.ar([0,1], 1, 0); // input

	PitchShift.ar //1st harmonic
	(
		z, //stereo input
		0.04, // grain windows size (seconds)
		(a**(fst_h)), // pitch ratio
		0, // maximum random deviation
		0, // maximum random time offset
		0.5, // output amp
		0 // output add

	)

	+

		PitchShift.ar //2nd harmonic
	(
		z, //stereo input
		0.04, // grain windows size (seconds)
		(a**(snd_h)), // pitch ratio
		0, // maximum random deviation
		0, // maximum random time offset
		0.5, // output amp
		0 // output add

	)

}.play;
)

(
{
	//arg h1, h2, h3, vol;

	//h1 = 440;
	//h2 = 785;
	//vol = 1;

	//left channel
	[
	PitchShift.ar(SoundIn.ar([0, 1]), 0.5, 1, 0.5, 0)
	//PitchShift.ar(SoundIn.ar([0, 1]), 0.5, 1, 0.5, 0)
	//SinOsc.ar(h1, 0, vol*0.5, 0) + // 1st harmonic
	//SinOsc.ar(h2, 0, vol*0.5, 0) // 2nd harmonic


,
	//right channel
	PitchShift.ar(SoundIn.ar([0, 1]), 0.5, 1, 0.5, 0)
	//PitchShift.ar(SoundIn.ar([0, 1]), 0.5, 1, 0.5, 0)
	//SinOsc.ar(h1, 0, vol*0.5, 0) + // 1st harmonic
	//SinOsc.ar(h2, 0, vol*0.5, 0) // 2nd harmonic
	]
}.play;

)

{SoundIn.ar([0,1], 1, 0)}.play;



(
// pitch shift input - USE HEADPHONES to prevent feedback.
{
	arg a, fst_h, snd_h;

	a = (2**(1/12));
	fst_h = 4;
	snd_h = 7;

	x = PitchShift.ar(SoundIn.ar([0, 1]), 0.04, a**fst_h, 0, 0.000, 0.5);
	y = PitchShift.ar(SoundIn.ar([0, 1]), 0.04, a**snd_h, 0, 0.000, 0.5);

	x+y;

}.play;
)





t.value(900, 903, 906).play; //pass harmonic component values
)

// reimplement usung SynthDef method TODO

(
h_3 = 2;
play({
    PitchShift.ar(
        SoundIn.ar([0, 1]),    // stereo mic input
		0.1,             // grain size (bigger = more latency)
        h_2,    // pitch shift ratio
        0,                 // pitch dispersion
        0            // time dispersion
    )
}))

(
h_3 = 2;
play({
    PitchShift.ar(
        SoundIn.ar([0, 1]),    // stereo mic input
		0.1,             // grain size (bigger = more latency)
        h_3,    // pitch shift ratio
        0,                 // pitch dispersion
        0            // time dispersion
    )
}))

(
h_3 = 2;
play({
    PitchShift.ar(
        SoundIn.ar([0, 1]),    // stereo mic input
		0.1,             // grain size (bigger = more latency)
        h_4,    // pitch shift ratio
        0,                 // pitch dispersion
        0            // time dispersion
    )
}))



// add reverb TODO

// interpolate output TODO

s.kill;


//stereo interprete
(
{
		arg h1, h2, h3, vol;

	h1 = 440;
	h2 = 900;
	h3 = 1100;
	vol = 1;

	[
		SinOsc.ar(h1, pi, 0.3, 0) + //left channel
		SinOsc.ar(h2, 0, 0.3, 0) +
		SinOsc.ar(h3, 0, 0.3, 0);


		,

		SinOsc.ar(h1, 0, 0.3, 0) + //right channel
		SinOsc.ar(h2, 0, 0.3, 0) +
		SinOsc.ar(h3, 0, 0.3, 0);
	]

}.play;
)


// Chord with SinOsc
(
{
	arg f0, a, b, x, y, fst_h, snd_h;

	f0 = 600;
	a = (2**(1/12));
	fst_h = 4;
	snd_h = 7;


	x = SinOsc.ar(f0, 0, 0.3, 0);
	y = SinOsc.ar((f0*(a**(fst_h))), 0, 0.3, 0);
	z = SinOsc.ar((f0*(a**(snd_h))), 0, 0.3, 0);

	x+y+z;

}.play;
)
//end





(
SynthDef("pitchFollow1",{
    var in, amp, freq, hasFreq, out;
    in = Mix.new(SoundIn.ar([0,1]));
    amp = Amplitude.kr(in, 0.05, 0.05);
    # freq, hasFreq = Pitch.kr(in, ampThreshold: 0.5, median: 5);
    // freq = Lag.kr(freq.cpsmidi.round(1).midicps, 0.05);
    out = Mix.new(VarSaw.ar(freq * [0.5,1,2], 0, LFNoise1.kr(0.3,0.1,0.1), amp));
    6.do({
        out = AllpassN.ar(out, 0.040, [0.040.rand,0.040.rand], 2)
    });
    Out.ar(0,out)
}).play(s);
)

(
// use audio input's amplitude to control PinkNoise amplitude - use headphones to prevent feedback.
{
	PinkNoise.ar(Amplitude.kr(SoundIn.ar(0)))
}.play
)














