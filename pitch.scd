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
		arg first_interval=4, second_interval=7, first_gain=1, second_gain=1, r_mix=0, r_room=0, d_wet=0, d_time=0;
		var s_in, s_out, pr1, pr2, first_voice, second_voice, s_in_harmonized, s_in_delayed;

		//Calculate pitch shift ratios for the 2 voices
		pr1 = 2**(first_interval/12);
		pr2 = 2**(second_interval/12);

		//Take the input from soundcard
		s_in = SoundIn.ar([0, 1]);

		//Compute first voice
		first_voice = PitchShift.ar(in:s_in, pitchRatio:pr1, mul:first_gain);
		//Compute second voice
		second_voice = PitchShift.ar(in:s_in, pitchRatio:pr2, mul:second_gain);
		//Compute the harmonized signal
		s_in_harmonized = s_in + first_voice + second_voice;

		//Process delay and sum it to the signal
		s_in_delayed = s_in_harmonized + CombC.ar(in:s_in_harmonized, maxdelaytime:1, delaytime:d_time, decaytime:5, mul:d_wet);

		//Compute the output as the reverb of the harmonized + delay signal
		s_out = FreeVerb.ar(in:s_in_delayed, mix:r_mix, room:r_room, damp:0.8);

		// compute the output into the default bus
		Out.ar(0, s_out)

}).add
)

NetAddr("127.0.0.1", 57120);

(
~synth = Synth(\harmonizer,[\grain,0.8,\pitchShiftRatio,0.1,\pitchDispersion,0.1,\timeDispersion,0.1,\amp,1,\offset,0.1,\vlas,1,\pan,0]);
)

(
f = {
	arg msg;

	var oscMsg = msg[0];

	if(msg[0] == '/harmony') {
		x=msg[1];
		y=msg[2];
        postln(oscMsg);
		postln("x:" +x+ "y:" +y);
		~synth.set(\first_gain, x,\second_gain, y);
	} {if(msg[0] == '/reverb') {
		x=msg[1];
		y=msg[2];
        postln(oscMsg);
		postln("x:" +x+ "y:" +y);
		~synth.set(\r_mix, x,\r_room, y);
	} {if(msg[0] == '/delay') {
		x=msg[1];
		y=msg[2];
        postln(oscMsg);
		postln("x:" +x+ "y:" +y);
		~synth.set(\d_wet, x,\d_time, y);
	} {if(msg[0] == '/chord') {
		x=msg[1];
		y=msg[2];
        postln(oscMsg);
		postln("x:" +x+ "y:" +y);
		~synth.set(\first_interval, x,\second_interval, y);
	}}}}
};

thisProcess.addOSCRecvFunc(f);
)


thisProcess.removeOSCRecvFunc(f);

