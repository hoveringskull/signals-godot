signal unblocked

func do_something_then_wait_until_unblocked_then_do_another_thing():
	print("do something")
	await unblocked
	print("do another thing")