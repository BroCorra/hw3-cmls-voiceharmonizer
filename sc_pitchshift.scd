
//PitchShift documentation available at:
//https://doc.sccode.org/Classes/PitchShift.html

//FreeReverb documentation available at:
//https://doc.sccode.org/Classes/FreeVerb.html

s.boot;

t = {
	arg h1, h2, h3, vol;

	//left channel
	a = SinOsc.ar(h1, 0, vol, 0); // 1st harmonic
	b = SinOsc.ar(h2, 0, vol*0.8, 0); // 2nd harmonic
	c = SinOsc.ar(h3, 0, 0.3*0.5, 0); // 3rd harmonic

,
	//right channel
	a = SinOsc.ar(h1, 0, vol, 0); // 1st harmonic
	b = SinOsc.ar(h2, 0, vol*0.8, 0); // 2nd harmonic
	c = SinOsc.ar(h3, 0, 0.3*0.5, 0); // 3rd harmonic

	a+b+c;
};

t.value(900, 903, 906).play; //pass harmonic component values


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