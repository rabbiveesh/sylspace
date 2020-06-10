# vim: ft=dockerfile
From perl:5.26

RUN cpanm Carton 
RUN mkdir /usr/src/app

WORKDIR /usr/src/app

COPY cpanfile* /usr/src/app/
RUN carton install

RUN mkdir /var/sylspace

COPY . /usr/src/app/

RUN carton exec perl -Ilib ./initsylspace.pl -f

RUN echo '{}' > SylSpace-Secrets.conf

RUN carton exec -- yath -j4 

RUN carton exec bin/load_site startersite

EXPOSE 8080

ENTRYPOINT [ "carton", "exec", "--" ]

CMD [ "hypnotoad", "-f", "SylSpace" ]
