require './config/environment'

use Rack::MethodOverride
use MotorcyclesController
use UsersController
use BrandsController
run ApplicationController