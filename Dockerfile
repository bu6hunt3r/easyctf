FROM python:latest
COPY index.html /
COPY mona_lisa.jpg /
EXPOSE 8080
CMD python -m http.server 8080
