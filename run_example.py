import openai

client = OpenAI(api_base="http://localhost:9001/v1", api_key="-")

audio_file = open("jfk.wav", "rb") # Sample from https://github.com/ggerganov/whisper.cpp/tree/master/samples
transcript = client.audio.transcriptions.create(
  model="anymodel", # whisper.cpp will auto select the model because can be only one loaded at once
  file=audio_file
)

print(transcript.text)