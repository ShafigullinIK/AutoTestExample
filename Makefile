build:
	docker build -t shafigullinik/exercise-java .

bash:
	docker run -it shafigullinik/exercise-java bash

compile:
	mvn compile

test:
	docker run shafigullinik/exercise-java mvn test