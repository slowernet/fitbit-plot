## fitbit plot

<a href="http://cl.ly/2z071W3N341D1h1J1h1o/Screen%20Shot%202012-02-21%20at%2010.47.58%20AM.png"><img src="http://cl.ly/2z071W3N341D1h1J1h1o/Screen%20Shot%202012-02-21%20at%2010.47.58%20AM.png" width="600" target="_blank" border="0"></a>

That kind of thing. 

## Install

* `git clone https://github.com/slowernet/fitbit-plot.git`
* `cd fitbit-plot`
* `cp config.rb.example config.rb`
* Go to [fitbit.com](http://fitbit.com/) and log in. Hover over your profile picture and note your user id in the URL: http://www.fitbit.com/user/XXXXXX, add to config.rb.
* Run through the [oauth process](https://github.com/whazzmaster/fitgem/wiki/The-OAuth-Process) via fitgem, and add your access token and access secret to config.rb.
* Run the app via rackup, shotgun, Passenger, etc.

## todo

* 4-day moving average is hardcoded, ugly. Make configurable.
* Select data to be graphed in the config rather than the html.
* Select colors in config.

## Privacy and disclaimer

Your copy of the application has read-only access to your data. I have no access to it. I assure you I don't have any interest in your data, but note that I take no responsibility for anything that happens if you choose to use this app. Like the man says:

> THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

## Acknowledgements

Built with [Sinatra](http://www.sinatrarb.com/intro), [fitgem](https://github.com/whazzmaster/fitgem) and [Flot](https://github.com/flot/flot). Thanks!

