---
title: Origins of term "Serverless"
date: 2017-06-21T15:39:00+02:00
tags: ["aws", "lambda", "serverless", "python"]
categories:
- aws
- lambda
- serverless
- python
---

Serverless is new trend in software development. It’s confusing many developers
around the world, let’s try to find origins of term “Serverless”.
First time Ken Fromm in 2012 use this term in his article.
(Ken added a bit of clarification in the comments to give credit where
credit is due.)

{{< tweet user="frommww" id="891719729932517376" >}}

{{< tweet user="frommww" id="891719804888817664" >}}

{{< tweet user="frommww" id="891719886375747584" >}}

{{< tweet user="frommww" id="891720299976179712" >}}

Later Badri Janakiraman mentioned that he also heard about usage of the term in 2012 in context
of Continuous Integration. For example Travis CI, where you can delegate
Continuous Integration and testing of your project to Travis CI.

Later in 2014  Amazon Web Services announced a new service Lambda, a stateless
event-driven compute service for dynamic applications that doesn’t require
provisioning of any compute infrastructure. As a result in 2015 we see lot’s
usage of term serverless.

In October 2015 there was a talk at Amazon’s re:Invent
conference titled “The Serverless Company using AWS Lambda”,
referring to PlayOn! Sports, where we can see real production usage of
AWS Lambda and Serverless architecture.
Let’s try to define term “Serverless”. Besides another trends in software
development, there is no one definition of this term.
  
Serverless is delegating hardware or infrastructure to third parties or vendors.
Serverless describes applications that depend on services ‘in the cloud’
to manage server-side logic and state. For example we have ‘rich client’  
and we want to use the vast ecosystem of cloud accessible databases
(like Parse, Firebase), authentication services (Auth0, AWS Cognito), etc.
These types of services have been previously described as
‘(Mobile) Backend as a Service’, and I’ll be using ‘BaaS’ as a shorthand
in the rest of this article.

Wikipidea said, that Serverless is applications where some amount of
server-side logic is still written by the application developer but unlike
traditional architectures is run in stateless compute containers that are
event-triggered, ephemeral (may only last for one invocation), and fully
managed by a 3rd party. (Thanks to ThoughtWorks for their definition in their
most recent Tech Radar.)

>One way to think of this is ‘Functions as a service / FaaS’ . AWS Lambda
is one of the most popular implementations of FaaS at present, but there
are others. I’ll be using ‘FaaS’ as a shorthand for this meaning of
Serverless throughout the rest of this article.
from https://martinfowler.com/articles/serverless.html

More info you can find in my latest talk from Pycon Italia 2017
[Building Serverless applications with Python](https://asoldatenko.org/pycon-italia-2017.html)
