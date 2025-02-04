import fs from "fs";
import OpenAI from "openai";

const openai = new OpenAI({
    baseURL: "http://localhost:9001/v1",
    apiKey: "-"
});

async function main() {
  const transcription = await openai.audio.transcriptions.create({
    file: fs.createReadStream("jfk.wav"), // Sample from https://github.com/ggerganov/whisper.cpp/tree/master/samples
    model: "anymodel", // whisper.cpp will auto select the model because can be only one loaded at once
  });

  console.log(transcription.text);
}
main();
