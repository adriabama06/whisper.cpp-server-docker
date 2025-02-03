ARG BASE_IMAGE=ubuntu:22.04

FROM ${BASE_IMAGE} AS build

WORKDIR /whisper.cpp

RUN apt update -y && apt install -y build-essential wget cmake git

RUN git clone https://github.com/ggerganov/whisper.cpp.git --depth 1 .

RUN make

FROM ${BASE_IMAGE} AS runtime

WORKDIR /whisper.cpp

RUN apt update -y && apt install -y curl ffmpeg wget cmake && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

COPY --from=build /whisper.cpp /whisper.cpp

COPY ./start.sh ./start.sh

RUN chmod +x ./start.sh

ENTRYPOINT [ "bash", "-c" ]
CMD [ "./start.sh" ]
