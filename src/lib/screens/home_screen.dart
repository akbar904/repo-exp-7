
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_animal_app/cubits/animal_cubit.dart';
import 'package:simple_animal_app/widgets/animal_text_widget.dart';

class HomeScreen extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Animal App'),
			),
			body: Center(
				child: BlocBuilder<AnimalCubit, AnimalState>(
					builder: (context, state) {
						if (state is Animal) {
							return GestureDetector(
								onTap: () => context.read<AnimalCubit>().toggleAnimal(),
								child: AnimalTextWidget(
									text: state.name,
									icon: state.icon,
								),
							);
						}
						return CircularProgressIndicator();
					},
				),
			),
		);
	}
}
