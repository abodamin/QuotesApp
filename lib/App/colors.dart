// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';

Color primeryDarkColor = Color(0xFFA47E5D);
Color primeryColor = Color(0xFFDCA46F);
Color primeryLightColor = Color(0xFFDCA46F);
Color yellowColor = Color(0xFFFDBD2F);
Color yellowColor2 = Color(0xFFFFDED0);
Color accentColor = Colors.white;
Color greenColor = Color(0xFF406455);
Color lightGreenColor = Color(0xFF669E87);

const errorColor = const Color(0xFFC5032B);

const kShrineSurfaceWhite = const Color(0xFFFFFBFA);
const kShrineBackgroundWhite = Colors.white;

//const Color loginGradientStart = const Color(0xFFfbab66);
//const Color loginGradientEnd = const Color(0xFFf7418c);
const Color loginGradientStart = Colors.pinkAccent;
const Color loginGradientEnd = Colors.pinkAccent;

const primaryGradient = const LinearGradient(
  colors: const [loginGradientStart, loginGradientEnd],
  stops: const [0.0, 1.0],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);

final overLayGradient = LinearGradient(
  colors: [Colors.transparent, Colors.black],
  stops: const [0.0, 1.0],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
);
