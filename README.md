# HealthCheckerNode

## Install

If you don't have a bundler in your system try this before: 
<pre>
    gem install bundle
</pre>

Do this steps bellow:
<pre>
  git clone git://github.com/aoqfonseca/healthChecker.git
  cd healthChecker
  bundle install 
</pre>

After this all gems that will need will be installed in your system. I strong recommend to use RVM for this.

## Super simple to use

The propose is create a simples webapp to check health link from another webapps and showing in the pretty funny way. This was make in Sinatra Ruby Framework and it is very simples to customize it.

The goals are:

* `very simple to use and configure` - I want to do something simple and very quickly to start. 
* `Rich and Funny interface` - There's a lot of other tools for this, but none of them is pretty or funny. I really want create an interface that you like see every time


## Make run (for user)

 Inside project there's a config yaml file. Open it and fill with an url, id and name for system that will want monitoring. Just follow the example that come in (see bellow)
<pre>
  ---
  projects:
    colaboracoes:
      id:     project1
      name:   project1
      url:    http://www.andrefonseca.net/healthcheck

    participacoes:
      id:     project2
      name:   project2
      url:    http://www.andrefonseca.net/healthcheck
</pre>

After, than you will have your configuration done, do: 
<pre>
    cd healthChecker
    ruby healthChecker 
</pre>

This will start mongrel server. To access, open your favorite browser and type: 
<pre>
    http://localhost:4567/
</pre>


That's all you need to get run your healthChecker funy pretty and usefull running.


## Make run (for developer)
  As i said before, this is a Sinatra Web app. Install all gems with bundle and let's code.

**Notice**
This is free for use and change. Feel free and colaborate.
