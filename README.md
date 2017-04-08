# Nu Cat

Dockerized version of the [Nu HTML Checker](https://github.com/validator/validator), running on [Tomcat](https://hub.docker.com/_/tomcat/).

Build with:

```
docker build -t nu-cat .
```

Run with:

```
docker run -p 8888:8080 nu-cat
```

You can find the validator at [http://localhost:8888](http://localhost:8888)

Also available on [Docker Hub](https://hub.docker.com/r/sitevalidator/nu-cat/).

## License

Nu Cat is released under the [MIT License](http://www.opensource.org/licenses/MIT).
