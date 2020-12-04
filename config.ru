require './config/environment'

use Rack::MethodOverride
use MotorcyclesController
use UsersController
run ApplicationController