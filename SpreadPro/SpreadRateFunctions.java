package com.SpreadPro;

public interface SpreadRateFunctions {
	
	double Calculate(double length, double width, double weight);
	
	double convert_tons_lbs(double tons);
	double convert_kg_lbs(double kgs);
	
	double convert_yds_ft(double yds);
	double convert_mi_ft(double mile);
	double convert_km_ft(double km);
	double convert_m_ft(double m);

}
