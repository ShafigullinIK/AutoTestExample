build:
	docker build -t shafigullinik/exercise-java .

bash:
	docker run -it shafigullinik/exercise-java bash

test:
	docker run shafigullinik/exercise-java ./mvnw test