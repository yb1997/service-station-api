# service-station-api

## Tech Stack
- Node.JS
- PostgreSQL

## Description

This is an api that acts as bridge connecting consumers and service station for booking different types of fillings(gas, petrol, diesel).
Currently supported features are:
- Authentication with authorization (roles are consumer and service-station).
- Consumers can find nearest service station for the type of filling they want.
- Consumers can book for filling for multiple vehicles with different kind of fillings.
- Service stations can call api to find out any orders made by consumers(only by unblocked and existing consumers).
- Service stations can upload photo of their station.
