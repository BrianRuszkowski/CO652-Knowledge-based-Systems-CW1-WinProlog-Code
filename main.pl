/*------------------------*/
/* A Simple Expert System */
/*------------------------*/



/*--------------- */
/* User Interface */
/*----------------*/

% Entry point for the diagnosis
main :-
	write('---------------------------------------'), nl,
      write('Welcome to the Medical Diagnosis System'), nl,
	write('-------------------------------------------------------------------------------------------------'), nl,
      write('Would you like to answer a questionnaire (type "q") or provide your symptoms directly (type "s")?'), nl,
	write('-------------------------------------------------------------------------------------------------'), nl,
      read(Choice),
      process_choice(Choice).

process_choice(q) :-
      ask_questions, % You need to define ask_questions/0 based on the previous examples
      main. % Return to the main menu after the questionnaire

process_choice(s) :-
      ask_symptoms(UserSymptoms),
      diagnose_based_on_symptoms(UserSymptoms),
      main. % Return to the main menu after providing symptoms

process_choice(_) :-
	write('----------------------------------------------------------------------'), nl,
      write('Invalid choice. Please type "q" for questionnaire or "s" for symptoms.'), nl,
      main. % Return to the main menu after invalid choice


% diseases with their symptoms and treatments
disease(flu, [fever, cough, sore_throat, runny_nose], 'Rest and drink plenty of fluids').
disease(common_cold, [cough, sneezing, runny_nose], 'Stay warm, rest and drink warm liquids').
disease(migraine, [headache, nausea, sensitivity_to_light], 'Use prescribed migraine medication and rest in a dark room').
disease(asthma, [shortness_of_breath, wheezing, chest_tightness], 'Use prescribed inhalers; avoid allergens and pollutants.').
disease(gastroenteritis, [nausea, vomiting, diarrhea, abdominal_pain], 'Stay hydrated, rest, and follow a BRAT diet.').
disease(hypertension, [headaches, shortness_of_breath, nosebleeds], 'Exercise, low-salt diet, medication, stress management.').
disease(diabetes, [increased_thirst, frequent_urination, hunger, fatigue, blurred_vision], 'Blood sugar monitoring, insulin, diet, exercise, medication.').
disease(allergic_rhinitis, [sneezing, itchy_eyes, watery_eyes, runny_nose, sinus_pressure], 'Antihistamines, nasal corticosteroids, avoid allergens, immunotherapy.').
disease(bronchitis, [persistent_cough, mucus_production, wheezing], 'Rest, stay hydrated, and use a humidifier.').
disease(osteoarthritis, [joint_pain, stiffness, swelling], 'Exercise, weight management, pain relievers, physical therapy.').
disease(heart_disease, [chest_pain, shortness_of_breath, fatigue], 'Lifestyle changes, medications, possibly surgery.').
disease(depression, [persistent_sadness, loss_of_interest, fatigue], 'Counseling, antidepressant medication, lifestyle changes.').
disease(anemia, [fatigue, weakness, pale_skin], 'Iron supplements, dietary changes, treating underlying causes.').
disease(uti, [burning_urination, frequent_urination, pelvic_pain], 'Increase water intake, prescribed antibiotics.').
disease(arthritis, [joint_pain, swelling, reduced_range_of_motion], 'Pain relievers, anti-inflammatory drugs, physical therapy.').
disease(chronic_kidney_disease, [nausea, vomiting, loss_of_appetite, fatigue, sleep_problems], 'Blood pressure control, diet changes, medication.').
disease(acute_sinusitis, [nasal_congestion, pain_in_sinuses, headache, fever], 'Decongestants, pain relievers, steam inhalation.').
disease(tuberculosis, [persistent_cough, weight_loss, night_sweats, fever], 'Antibiotics for a long duration.').
disease(covid_19, [fever, cough, shortness_of_breath, loss_of_taste_or_smell], 'Follow local health guidelines, rest, and stay hydrated. Seek medical attention if symptoms worsen.').
disease(pneumonia, [chest_pain, cough_with_phlegm, fever, shortness_of_breath], 'Antibiotics, rest, and hydration. Severe cases may require hospitalization.').
disease(chickenpox, [itchy_rash, fever, fatigue, loss_of_appetite], 'Antiviral medication for severe cases, calamine lotion, and rest.').
disease(measles, [fever, cough, runny_nose, inflamed_eyes, skin_rash], 'Supportive care to relieve symptoms, vitamin A supplements.').
disease(influenza, [fever, cough, sore_throat, muscle_aches], 'Antiviral drugs, rest, and plenty of fluids.').

/*---------------------------*/
/*Check Symptoms find disease*/
/*---------------------------*/
		
% Check if the user has all symptoms of a disease or certain ones
check_symptoms(UserSymptoms, DiseaseSymptoms) :-
      subset(UserSymptoms, DiseaseSymptoms).

% Check list of diseases provided
subset([], _).
subset([H|T], List) :-
      member(H, List),
      subset(T, List).

% Check the user's symptoms match with a disease and provide a diagnosis
diagnose(Disease, Treatment, UserSymptoms) :-
      disease(Disease, Symptoms, Treatment),
      check_symptoms(UserSymptoms, Symptoms).

/*--------------*/
/*Knowledge Base*/
/*--------------*/

% Ask user for their symptoms
ask_symptoms(Symptoms) :-
	write('************************************************************'), nl,
      write('Enter your symptoms as a Prolog list (e.g., [fever, cough]).'), nl,
	write('************************************************************'), nl,
      read(Symptoms).

% Ask a series of questions to diagnose diseases
ask_questions :-
    ask_flu,
    ask_common_cold,
    ask_migraine,
    ask_asthma,
    ask_gastroenteritis,
    ask_hypertension,
    ask_diabetes,
    ask_allergic_rhinitis,
    ask_covid_19,
    ask_pneumonia,
    ask_chickenpox,
    ask_measles,
    ask_influenza,
    ask_bronchitis,
    ask_osteoarthritis,
    ask_heart_disease,
    ask_depression,
    ask_anemia,
    ask_uti,
    ask_arthritis,
    ask_chronic_kidney_disease,
    ask_acute_sinusitis,
    ask_tuberculosis.

ask_flu :-
      write('Do you have a fever, cough, sore throat, or runny nose? (yes/no)'), nl,
      read(Response),
      (Response == yes -> diagnose_based_on_symptoms([fever, cough, sore_throat, runny_nose]); true).

ask_common_cold :-
      write('Do you have a cough, are you sneezing, or do you have a runny nose? (yes/no)'), nl,
      read(Response),
      (Response == yes -> diagnose_based_on_symptoms([cough, sneezing, runny_nose]); true).

ask_migraine :-
      write('Do you have a headache, nausea, or sensitivity to light? (yes/no)'), nl,
      read(Response),
      (Response == yes -> diagnose_based_on_symptoms([headache, nausea, sensitivity_to_light]); true).

ask_asthma :-
      write('Do you have shortness of breath, wheezing, or chest tightness? (yes/no)'), nl,
      read(Response),
      (Response == yes -> diagnose_based_on_symptoms([shortness_of_breath, wheezing, chest_tightness]); true).

ask_gastroenteritis :-
      write('Do you have nausea, vomiting, diarrhea, or abdominal pain? (yes/no)'), nl,
      read(Response),
      (Response == yes -> diagnose_based_on_symptoms([nausea, vomiting, diarrhea, abdominal_pain]); true).

ask_hypertension :-
      write('Do you have headaches, shortness of breath, or nosebleeds? (yes/no)'), nl,
      read(Response),
      (Response == yes -> diagnose_based_on_symptoms([headaches, shortness_of_breath, nosebleeds]); true).

ask_diabetes :-
      write('Do you have increased thirst, frequent urination, hunger, fatigue, or blurred vision? (yes/no)'), nl,
      read(Response),
      (Response == yes -> diagnose_based_on_symptoms([increased_thirst, frequent_urination, hunger, fatigue, blurred_vision]); true).

ask_allergic_rhinitis :-
      write('Do you have sneezing, itchy eyes, watery eyes, runny nose, or sinus pressure? (yes/no)'), nl,
      read(Response),
      (Response == yes -> diagnose_based_on_symptoms([sneezing, itchy_eyes, watery_eyes, runny_nose, sinus_pressure]); true).

ask_covid_19 :-
      write('Do you have fever, cough, shortness of breath, or loss of taste or smell? (yes/no)'), nl,
      read(Response),
      (Response == yes -> diagnose_based_on_symptoms([fever, cough, shortness_of_breath, loss_of_taste_or_smell]); true).

ask_pneumonia :-
      write('Do you have chest pain, cough with phlegm, fever, or shortness of breath? (yes/no)'), nl,
      read(Response),
      (Response == yes -> diagnose_based_on_symptoms([chest_pain, cough_with_phlegm, fever, shortness_of_breath]); true).

ask_chickenpox :-
      write('Do you have an itchy rash, fever, fatigue, or loss of appetite? (yes/no)'), nl,
      read(Response),
      (Response == yes -> diagnose_based_on_symptoms([itchy_rash, fever, fatigue, loss_of_appetite]); true).

ask_measles :-
      write('Do you have fever, cough, runny nose, inflamed eyes, or skin rash? (yes/no)'), nl,
      read(Response),
      (Response == yes -> diagnose_based_on_symptoms([fever, cough, runny_nose, inflamed_eyes, skin_rash]); true).

ask_influenza :-
      write('Do you have fever, cough, sore throat, or muscle aches? (yes/no)'), nl,
      read(Response),
      (Response == yes -> diagnose_based_on_symptoms([fever, cough, sore_throat, muscle_aches]); true).

ask_bronchitis :-
      write('Do you have a persistent cough, mucus production, or wheezing? (yes/no)'), nl,
      read(Response),
      (Response == yes -> diagnose_based_on_symptoms([persistent_cough, mucus_production, wheezing]); true).

ask_osteoarthritis :-
      write('Do you have joint pain, stiffness, or swelling? (yes/no)'), nl,
      read(Response),
      (Response == yes -> diagnose_based_on_symptoms([joint_pain, stiffness, swelling]); true).

ask_heart_disease :-
      write('Do you have chest pain, shortness of breath, or fatigue? (yes/no)'), nl,
      read(Response),
      (Response == yes -> diagnose_based_on_symptoms([chest_pain, shortness_of_breath, fatigue]); true).

ask_depression :-
      write('Do you experience persistent sadness, loss of interest, or fatigue? (yes/no)'), nl,
      read(Response),
      (Response == yes -> diagnose_based_on_symptoms([persistent_sadness, loss_of_interest, fatigue]); true).

ask_anemia :-
      write('Do you feel fatigued, weak, or have pale skin? (yes/no)'), nl,
      read(Response),
      (Response == yes -> diagnose_based_on_symptoms([fatigue, weakness, pale_skin]); true).

ask_uti :-
      write('Do you experience burning urination, frequent urination, or pelvic pain? (yes/no)'), nl,
      read(Response),
      (Response == yes -> diagnose_based_on_symptoms([burning_urination, frequent_urination, pelvic_pain]); true).

ask_arthritis :-
      write('Do you have joint pain, swelling, or reduced range of motion? (yes/no)'), nl,
      read(Response),
      (Response == yes -> diagnose_based_on_symptoms([joint_pain, swelling, reduced_range_of_motion]); true).

ask_chronic_kidney_disease :-
      write('Do you experience nausea, vomiting, loss of appetite, fatigue, or sleep problems? (yes/no)'), nl,
      read(Response),
      (Response == yes -> diagnose_based_on_symptoms([nausea, vomiting, loss_of_appetite, fatigue, sleep_problems]); true).

ask_acute_sinusitis :-
      write('Do you have nasal congestion, pain in sinuses, headache, or fever? (yes/no)'), nl,
      read(Response),
      (Response == yes -> diagnose_based_on_symptoms([nasal_congestion, pain_in_sinuses, headache, fever]); true).

ask_tuberculosis :-
      write('Do you have a persistent cough, weight loss, night sweats, or fever? (yes/no)'), nl,
      read(Response),
      (Response == yes -> diagnose_based_on_symptoms([persistent_cough, weight_loss, night_sweats, fever]); true).

/*-----------*/
/* Responses */
/*-----------*/

% Define diagnose based on symptoms provide from the questionnaire
diagnose_based_on_symptoms(UserSymptoms) :-
      (diagnose(Disease, Treatment, UserSymptoms) ->
       write('Based on your symptoms, you might have '), write(Disease),
       write('. Suggested treatment: '), write(Treatment), nl
      ;write('Unable to determine a diagnosis based on the provided symptoms.'), nl
      ).

% Define diagnose based on entered symptoms 
diagnose_based_on_symptoms(UserSymptoms) :-
      (UserSymptoms = [], % Check for empty list indicating no symptoms entered
      write('No symptoms were entered. Please try again.'), nl
      ;UserSymptoms \= [], % Check if the list is not empty
            (diagnose(Disease, Treatment, UserSymptoms) ->
            write('Based on your symptoms, you might have '), write(Disease),
            write('. Suggested treatment: '), write(Treatment), nl
            ;write('Unable to determine a diagnosis based on the provided symptoms.'), nl
            )
      ).

/*------------------------------*/
/* END OF MEDICAL EXPERT SYSTEM */
/*------------------------------*/