extends Path3D

func _ready():
	var curve_ref = self.curve   # ดึง Curve3D ออกมา
	var point_count = curve_ref.get_point_count()

	var start_index = 0  # index ของจุดล่างสุด
	var new_curve = Curve3D.new()

	for i in range(point_count):
		var idx = (start_index + i) % point_count
		new_curve.add_point(
			curve_ref.get_point_position(idx),
			curve_ref.get_point_in(idx),
			curve_ref.get_point_out(idx),
			curve_ref.get_point_tilt(idx)
		)

	self.curve = new_curve
