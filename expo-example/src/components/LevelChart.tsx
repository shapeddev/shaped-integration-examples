import React, { useEffect, useState } from 'react';
import { View, StyleSheet, Dimensions, Text } from 'react-native';
import Svg, { Defs, LinearGradient, Stop, Polygon } from 'react-native-svg';

const { width } = Dimensions.get('window');

type LevelChartProps = {
  offsetX?: number;
  offsetY?: number;
  isValid?: boolean;
};

const LevelChart: React.FC<LevelChartProps> = ({
  offsetX = 0,
  offsetY = 0,
  isValid = false,
}) => {
  const graphHeight = 75;
  const [animatedWaterLevel, setAnimatedWaterLevel] = useState({
    left: graphHeight / 2,
    right: graphHeight / 2,
  });

  const gradientStart = isValid ? '#66E66D' : '#FF6F61';
  const gradientEnd = isValid ? '#157A1F' : '#B32121';

  const clampedOffsetX = Math.max(-50, Math.min(50, offsetX));
  const clampedOffsetY = Math.max(-30, Math.min(30, offsetY));

  let targetWaterLevelLeft =
    graphHeight / 2 - clampedOffsetY - clampedOffsetX * 0.5;
  let targetWaterLevelRight =
    graphHeight / 2 - clampedOffsetY + clampedOffsetX * 0.5;

  if (isValid) {
    targetWaterLevelLeft = 0;
    targetWaterLevelRight = 0;
  } else {
    targetWaterLevelLeft = Math.min(targetWaterLevelLeft, graphHeight - 10);
    targetWaterLevelRight = Math.min(targetWaterLevelRight, graphHeight - 10);
  }

  useEffect(() => {
    const interval = setInterval(() => {
      setAnimatedWaterLevel((prev) => ({
        left: prev.left + (targetWaterLevelLeft - prev.left) * 0.1,
        right: prev.right + (targetWaterLevelRight - prev.right) * 0.1,
      }));
    }, 16);

    return () => clearInterval(interval);
  }, [targetWaterLevelLeft, targetWaterLevelRight]);

  return (
    <View style={styles.container}>
      <Svg width={width} height={graphHeight}>
        <Defs>
          <LinearGradient id="waterGradient" x1="0" y1="0" x2="0" y2="1">
            <Stop offset="0%" stopColor={gradientStart} stopOpacity="1" />
            <Stop offset="100%" stopColor={gradientEnd} stopOpacity="1" />
          </LinearGradient>
        </Defs>

        <Polygon
          points={`0,${animatedWaterLevel.left} ${width},${animatedWaterLevel.right} ${width},${graphHeight} 0,${graphHeight}`}
          fill="url(#waterGradient)"
        />
      </Svg>

      <Text style={[styles.text, { color: isValid ? '#157A1F' : '#B32121' }]}>
        {isValid ? 'Nível válido' : 'Nível inválido'}
      </Text>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    alignItems: 'center',
    justifyContent: 'center',
    padding: 10,
    position: 'relative',
  },
  text: {
    position: 'absolute',
    top: '40%',
    fontSize: 16,
    fontWeight: 'bold',
  },
});

export default LevelChart;
