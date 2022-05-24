# see the URL below for information on how to write OpenStudio measures
# http://nrel.github.io/OpenStudio-user-documentation/measures/measure_writing_guide/

# start the measure
class AddGroundTemperatureEnergyPlusObject < OpenStudio::Ruleset::WorkspaceUserScript

  # human readable name
  def name
    return "Add Ground Temperature EnergyPlus Object"
  end

  # human readable description
  def description
    return "Temporary solution to underground heat transfer. Must have surfaces with outside BC = Ground. Default temperature argument values are from Fort Collins TMY3 file."
  end

  # human readable description of modeling approach
  def modeler_description
    return ""
  end

  # define the arguments that the user will input
  def arguments(workspace)
    args = OpenStudio::Ruleset::OSArgumentVector.new

    # Define input variables
    jan_temp = OpenStudio::Ruleset::OSArgument::makeDoubleArgument("jan_temp",true)
    jan_temp.setDisplayName("Ground Temperature in January")
    jan_temp.setDefaultValue(5.09)
    args << jan_temp

    feb_temp = OpenStudio::Ruleset::OSArgument::makeDoubleArgument("feb_temp",true)
    feb_temp.setDisplayName("Ground Temperature in February")
    feb_temp.setDefaultValue(1.17)
    args << feb_temp

    mar_temp = OpenStudio::Ruleset::OSArgument::makeDoubleArgument("mar_temp",true)
    mar_temp.setDisplayName("Ground Temperature in March")
    mar_temp.setDefaultValue(-0.7)
    args << mar_temp

    apr_temp = OpenStudio::Ruleset::OSArgument::makeDoubleArgument("apr_temp",true)
    apr_temp.setDisplayName("Ground Temperature in April")
    apr_temp.setDefaultValue(-0.76)
    args << apr_temp

    may_temp = OpenStudio::Ruleset::OSArgument::makeDoubleArgument("may_temp",true)
    may_temp.setDisplayName("Ground Temperature in May")
    may_temp.setDefaultValue(2.22)
    args << may_temp

    jun_temp = OpenStudio::Ruleset::OSArgument::makeDoubleArgument("jun_temp",true)
    jun_temp.setDisplayName("Ground Temperature in June")
    jun_temp.setDefaultValue(6.55)
    args << jun_temp

    jul_temp = OpenStudio::Ruleset::OSArgument::makeDoubleArgument("jul_temp",true)
    jul_temp.setDisplayName("Ground Temperature in July")
    jul_temp.setDefaultValue(11.21)
    args << jul_temp

    aug_temp = OpenStudio::Ruleset::OSArgument::makeDoubleArgument("aug_temp",true)
    aug_temp.setDisplayName("Ground Temperature in August")
    aug_temp.setDefaultValue(15.2)
    args << aug_temp

    sept_temp = OpenStudio::Ruleset::OSArgument::makeDoubleArgument("sept_temp",true)
    sept_temp.setDisplayName("Ground Temperature in September")
    sept_temp.setDefaultValue(17.26)
    args << sept_temp

    oct_temp = OpenStudio::Ruleset::OSArgument::makeDoubleArgument("oct_temp",true)
    oct_temp.setDisplayName("Ground Temperature in October")
    oct_temp.setDefaultValue(16.88)
    args << oct_temp

    nov_temp = OpenStudio::Ruleset::OSArgument::makeDoubleArgument("nov_temp",true)
    nov_temp.setDisplayName("Ground Temperature in November")
    nov_temp.setDefaultValue(14.12)
    args << nov_temp

    dec_temp = OpenStudio::Ruleset::OSArgument::makeDoubleArgument("dec_temp",true)
    dec_temp.setDisplayName("Ground Temperature in December")
    dec_temp.setDefaultValue(9.9)
    args << dec_temp

    return args
  end

  # define what happens when the measure is run
  def run(workspace, runner, user_arguments)
    super(workspace, runner, user_arguments)

    # use the built-in error checking
    if !runner.validateUserArguments(arguments(workspace), user_arguments)
      return false
    end

    jan_temp = runner.getDoubleArgumentValue("jan_temp",user_arguments)
    feb_temp = runner.getDoubleArgumentValue("feb_temp",user_arguments)
    mar_temp = runner.getDoubleArgumentValue("mar_temp",user_arguments)
    apr_temp = runner.getDoubleArgumentValue("apr_temp",user_arguments)
    may_temp = runner.getDoubleArgumentValue("may_temp",user_arguments)
    jun_temp = runner.getDoubleArgumentValue("jun_temp",user_arguments)
    jul_temp = runner.getDoubleArgumentValue("jul_temp",user_arguments)
    aug_temp = runner.getDoubleArgumentValue("aug_temp",user_arguments)
    sept_temp = runner.getDoubleArgumentValue("sept_temp",user_arguments)
    oct_temp = runner.getDoubleArgumentValue("oct_temp",user_arguments)
    nov_temp = runner.getDoubleArgumentValue("nov_temp",user_arguments)
    dec_temp = runner.getDoubleArgumentValue("dec_temp",user_arguments)

		groundTemps = "
		Site:GroundTemperature:BuildingSurface,
			#{jan_temp},
			#{feb_temp},
			#{mar_temp},
			#{apr_temp},
			#{may_temp},
			#{jun_temp},
			#{jul_temp},
			#{aug_temp},
			#{sept_temp},
			#{oct_temp},
			#{nov_temp},
			#{dec_temp};
			"
		idfObject = OpenStudio::IdfObject::load(groundTemps)
		object = idfObject.get
		wsObject = workspace.addObject(object)

		runner.registerInfo("Ground Temperatures Added.")

    return true

  end

end

# register the measure to be used by the application
AddGroundTemperatureEnergyPlusObject.new.registerWithApplication
