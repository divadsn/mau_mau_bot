FROM python:alpine

RUN apk add --no-cache gettext

WORKDIR /app
ADD requirements.txt .
RUN pip install -r requirements.txt

ADD . ./
RUN cd locales && find . -maxdepth 2 -type d -name 'LC_MESSAGES' -exec ash -c 'msgfmt {}/unobot.po -o {}/unobot.mo' \;

VOLUME /app/data
ENV UNO_DB="/app/data/uno.sqlite3"

ENTRYPOINT [ "python", "bot.py" ]
