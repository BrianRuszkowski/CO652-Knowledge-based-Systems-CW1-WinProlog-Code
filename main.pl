/*------------------------*/
/* A Simple Expert System */
/*------------------------*/

/*--------------- */
/* User Interface */
/*----------------*/

% Main entry point
main :-
	write('---------------------------------------'), nl,
    write('Welcome to the Medical Diagnosis System'), nl,
	write('-------------------------------------------------------------------------------------------------'), nl,
    write('Would you like to answer a questionnaire (type "q") or provide your symptoms directly (type "s")?'), nl,
	write('-------------------------------------------------------------------------------------------------'), nl,
    read(Choice),
    process_choice(Choice).

% Handles the user choice
process_choice(q) :-
    ask_questions, % Asks a series of questions
    main. % Returns to the main menu

process_choice(s) :-
    ask_symptoms(UserSymptoms),
    diagnose(UserSymptoms),
    main. % Returns to the main menu

process_choice(_) :-
	write('----------------------------------------------------------------------'), nl,
    write('Invalid choice. Please type "q" for questionnaire or "s" for symptoms.'), nl,
    main. % Invalid choice, returns to the main menu

/*---------------------------*/
/* Check Symptoms and Diagnose*/
/*---------------------------*/

% Checks symptoms against disease symptoms and their weights
check_weighted_symptoms(UserSymptoms, DiseaseSymptoms, DiseaseWeights, Score) :-
    calculate_match_score(UserSymptoms, DiseaseSymptoms, DiseaseWeights, Score).

% Calculates match score by adding weights of matching symptoms
calculate_match_score([], _, _, 0).
calculate_match_score([Symptom|UserRest], DiseaseSymptoms, [Weight|WeightRest], Score) :-
    (member(Symptom, DiseaseSymptoms) -> 
        calculate_match_score(UserRest, DiseaseSymptoms, WeightRest, RestScore),
        Score is RestScore + Weight
    ; calculate_match_score(UserRest, DiseaseSymptoms, WeightRest, Score)
    ).

% Validates symptoms by separating recognised and unrecognised symptoms
validate_symptoms([], [], []).
validate_symptoms([Symptom|Rest], [Symptom|ValidRest], Unrecognised) :-
    disease(_, DiseaseSymptoms, _, _, _),
    member(Symptom, DiseaseSymptoms), !,
    validate_symptoms(Rest, ValidRest, Unrecognised).
validate_symptoms([Symptom|Rest], Valid, [Symptom|UnrecognisedRest]) :-
    validate_symptoms(Rest, Valid, UnrecognisedRest).

% Matches user symptoms with disease and gives diagnosis
diagnose(Disease, Treatment, UserSymptoms) :-
    disease(Disease, Symptoms, Weights, _, Treatment),
    check_weighted_symptoms(UserSymptoms, Symptoms, Weights, Score).

/*--------------*/
/* Knowledge Base*/
/*--------------*/

% Diseases with symptoms, weights, priority, and treatments
disease(flu, [fever, cough, sore_throat, runny_nose], [3, 2, 1, 1], 0.9, 'Rest and drink plenty of fluids').
disease(common_cold, [cough, sneezing, runny_nose], [2, 2, 1], 0.7, 'Stay warm, rest, and drink warm liquids').
disease(migraine, [headache, nausea, sensitivity_to_light], [3, 2, 2], 0.8, 'Use prescribed migraine medication and rest in a dark room').
disease(asthma, [shortness_of_breath, wheezing, chest_tightness], [3, 2, 2], 0.85, 'Use prescribed inhalers; avoid allergens and pollutants.').
disease(gastroenteritis, [nausea, vomiting, diarrhoea, abdominal_pain], [3, 3, 2, 2], 0.75, 'Stay hydrated, rest, and follow a BRAT diet.').
disease(hypertension, [headaches, shortness_of_breath, nosebleeds], [2, 3, 2], 0.9, 'Exercise, low-salt diet, medication, stress management.').
disease(diabetes, [increased_thirst, frequent_urination, hunger, fatigue, blurred_vision], [3, 3, 2, 2, 1], 0.95, 'Blood sugar monitoring, insulin, diet, exercise, medication.').
disease(allergic_rhinitis, [sneezing, itchy_eyes, watery_eyes, runny_nose, sinus_pressure], [2, 2, 1, 1, 1], 0.8, 'Antihistamines, nasal corticosteroids, avoid allergens, immunotherapy.').
disease(bronchitis, [persistent_cough, mucus_production, wheezing], [3, 2, 1], 0.85, 'Rest, stay hydrated, and use a humidifier.').
disease(osteoarthritis, [joint_pain, stiffness, swelling], [3, 2, 1], 0.8, 'Exercise, weight management, pain relievers, physical therapy.').
disease(heart_disease, [chest_pain, shortness_of_breath, fatigue], [3, 3, 2], 0.95, 'Lifestyle changes, medications, possibly surgery.').
disease(depression, [persistent_sadness, loss_of_interest, fatigue], [3, 2, 2], 0.85, 'Counselling, antidepressant medication, lifestyle changes.').
disease(anaemia, [fatigue, weakness, pale_skin], [3, 2, 2], 0.75, 'Iron supplements, dietary changes, treating underlying causes.').
disease(uti, [burning_urination, frequent_urination, pelvic_pain], [3, 3, 2], 0.8, 'Increase water intake, prescribed antibiotics.').
disease(arthritis, [joint_pain, swelling, reduced_range_of_motion], [3, 2, 2], 0.8, 'Pain relievers, anti-inflammatory drugs, physical therapy.').
disease(chronic_kidney_disease, [nausea, vomiting, loss_of_appetite, fatigue, sleep_problems], [2, 2, 2, 1, 1], 0.85, 'Blood pressure control, diet changes, medication.').
disease(acute_sinusitis, [nasal_congestion, pain_in_sinuses, headache, fever], [2, 2, 1, 1], 0.75, 'Decongestants, pain relievers, steam inhalation.').
disease(tuberculosis, [persistent_cough, weight_loss, night_sweats, fever], [3, 3, 2, 2], 0.9, 'Antibiotics for a long duration.').
disease(covid_19, [fever, cough, shortness_of_breath, loss_of_taste_or_smell], [3, 3, 2, 2], 0.95, 'Follow local health guidelines, rest, and stay hydrated. Seek medical attention if symptoms worsen.').
disease(pneumonia, [chest_pain, cough_with_phlegm, fever, shortness_of_breath], [3, 2, 2, 2], 0.85, 'Antibiotics, rest, and hydration. Severe cases may require hospitalisation.').
disease(chickenpox, [itchy_rash, fever, fatigue, loss_of_appetite], [3, 2, 1, 1], 0.8, 'Antiviral medication for severe cases, calamine lotion, and rest.').
disease(measles, [fever, cough, runny_nose, inflamed_eyes, skin_rash], [2, 2, 2, 1, 1], 0.85, 'Supportive care to relieve symptoms, vitamin A supplements.').
disease(influenza, [fever, cough, sore_throat, muscle_aches], [3, 2, 2, 2], 0.9, 'Antiviral drugs, rest, and plenty of fluids.').

/*--------------*/
/* Ask Questions*/
/*--------------*/

% Asks questions to diagnose diseases
ask_questions :-
    ask_flu,
    ask_common_cold,
    ask_migraine,
    ask_asthma,
    ask_gastroenteritis,
    ask_hypertension,
    ask_diabetes,
    ask_allergic_rhinitis,
    ask_bronchitis,
    ask_osteoarthritis,
    ask_heart_disease,
    ask_depression,
    ask_anaemia,
    ask_uti,
    ask_arthritis,
    ask_chronic_kidney_disease,
    ask_acute_sinusitis,
    ask_tuberculosis,
    ask_covid_19,
    ask_pneumonia,
    ask_chickenpox,
    ask_measles,
    ask_influenza.

% Each ask_X predicate corresponds to a disease
ask_flu :-
    write('Do you have a fever, cough, sore throat, or runny nose? (yes/no)'), nl,
    read(Response),
    (Response == yes -> diagnose([fever, cough, sore_throat, runny_nose]); true).

ask_common_cold :-
    write('Do you have a cough, are you sneezing, or do you have a runny nose? (yes/no)'), nl,
    read(Response),
    (Response == yes -> diagnose([cough, sneezing, runny_nose]); true).

ask_migraine :-
    write('Do you have a headache, nausea, or sensitivity to light? (yes/no)'), nl,
    read(Response),
    (Response == yes -> diagnose([headache, nausea, sensitivity_to_light]); true).

ask_asthma :-
    write('Do you have shortness of breath, wheezing, or chest tightness? (yes/no)'), nl,
    read(Response),
    (Response == yes -> diagnose([shortness_of_breath, wheezing, chest_tightness]); true).

ask_gastroenteritis :-
    write('Do you have nausea, vomiting, diarrhoea, or abdominal pain? (yes/no)'), nl,
    read(Response),
    (Response == yes -> diagnose([nausea, vomiting, diarrhoea, abdominal_pain]); true).

ask_hypertension :-
    write('Do you have headaches, shortness of breath, or nosebleeds? (yes/no)'), nl,
    read(Response),
    (Response == yes -> diagnose([headaches, shortness_of_breath, nosebleeds]); true).

ask_diabetes :-
    write('Do you have increased thirst, frequent urination, hunger, fatigue, or blurred vision? (yes/no)'), nl,
    read(Response),
    (Response == yes -> diagnose([increased_thirst, frequent_urination, hunger, fatigue, blurred_vision]); true).

ask_allergic_rhinitis :-
    write('Do you have sneezing, itchy eyes, watery eyes, runny nose, or sinus pressure? (yes/no)'), nl,
    read(Response),
    (Response == yes -> diagnose([sneezing, itchy_eyes, watery_eyes, runny_nose, sinus_pressure]); true).

ask_bronchitis :-
    write('Do you have a persistent cough, mucus production, or wheezing? (yes/no)'), nl,
    read(Response),
    (Response == yes -> diagnose([persistent_cough, mucus_production, wheezing]); true).

ask_osteoarthritis :-
    write('Do you have joint pain, stiffness, or swelling? (yes/no)'), nl,
    read(Response),
    (Response == yes -> diagnose([joint_pain, stiffness, swelling]); true).

ask_heart_disease :-
    write('Do you have chest pain, shortness of breath, or fatigue? (yes/no)'), nl,
    read(Response),
    (Response == yes -> diagnose([chest_pain, shortness_of_breath, fatigue]); true).

ask_depression :-
    write('Do you experience persistent sadness, loss of interest, or fatigue? (yes/no)'), nl,
    read(Response),
    (Response == yes -> diagnose([persistent_sadness, loss_of_interest, fatigue]); true).

ask_anaemia :-
    write('Do you feel fatigued, weak, or have pale skin? (yes/no)'), nl,
    read(Response),
    (Response == yes -> diagnose([fatigue, weakness, pale_skin]); true).

ask_uti :-
    write('Do you experience burning urination, frequent urination, or pelvic pain? (yes/no)'), nl,
    read(Response),
    (Response == yes -> diagnose([burning_urination, frequent_urination, pelvic_pain]); true).

ask_arthritis :-
    write('Do you have joint pain, swelling, or reduced range of motion? (yes/no)'), nl,
    read(Response),
    (Response == yes -> diagnose([joint_pain, swelling, reduced_range_of_motion]); true).

ask_chronic_kidney_disease :-
    write('Do you experience nausea, vomiting, loss of appetite, fatigue, or sleep problems? (yes/no)'), nl,
    read(Response),
    (Response == yes -> diagnose([nausea, vomiting, loss_of_appetite, fatigue, sleep_problems]); true).

ask_acute_sinusitis :-
    write('Do you have nasal congestion, pain in sinuses, headache, or fever? (yes/no)'), nl,
    read(Response),
    (Response == yes -> diagnose([nasal_congestion, pain_in_sinuses, headache, fever]); true).

ask_tuberculosis :-
    write('Do you have a persistent cough, weight loss, night sweats, or fever? (yes/no)'), nl,
    read(Response),
    (Response == yes -> diagnose([persistent_cough, weight_loss, night_sweats, fever]); true).

ask_covid_19 :-
    write('Do you have fever, cough, shortness of breath, or loss of taste or smell? (yes/no)'), nl,
    read(Response),
    (Response == yes -> diagnose([fever, cough, shortness_of_breath, loss_of_taste_or_smell]); true).

ask_pneumonia :-
    write('Do you have chest pain, cough with phlegm, fever, or shortness of breath? (yes/no)'), nl,
    read(Response),
    (Response == yes -> diagnose([chest_pain, cough_with_phlegm, fever, shortness_of_breath]); true).

ask_chickenpox :-
    write('Do you have an itchy rash, fever, fatigue, or loss of appetite? (yes/no)'), nl,
    read(Response),
    (Response == yes -> diagnose([itchy_rash, fever, fatigue, loss_of_appetite]); true).

ask_measles :-
    write('Do you have fever, cough, runny nose, inflamed eyes, or skin rash? (yes/no)'), nl,
    read(Response),
    (Response == yes -> diagnose([fever, cough, runny_nose, inflamed_eyes, skin_rash]); true).

ask_influenza :-
    write('Do you have fever, cough, sore throat, or muscle aches? (yes/no)'), nl,
    read(Response),
    (Response == yes -> diagnose([fever, cough, sore_throat, muscle_aches]); true).

/*-----------*/
/* Responses */
/*-----------*/

% Caches previous diagnosis for faster results
:- dynamic memoized_diagnosis/2.

% Memoized diagnosis based on symptoms
diagnose(UserSymptoms) :-
    validate_symptoms(UserSymptoms, ValidSymptoms, UnrecognisedSymptoms),
    (UnrecognisedSymptoms \= [] ->
        write('The following symptoms were not recognised: '), write(UnrecognisedSymptoms), nl,
        write('Please check the spelling or use known symptoms.'), nl
    ; diagnose_without_memo(ValidSymptoms)
    ).

% Diagnoses based on valid symptoms
diagnose_without_memo(ValidSymptoms) :-
    findall((Priority, Disease, Treatment), 
            (disease(Disease, DiseaseSymptoms, Weights, Priority, Treatment),
             check_weighted_symptoms(ValidSymptoms, DiseaseSymptoms, Weights, Score),
             Score > 0), 
            Diagnoses),
    keysort(Diagnoses, SortedDiagnoses),
    reverse(SortedDiagnoses, ReversedDiagnoses), % Reverses to get highest priority first
    diagnose_based_on_sorted(ReversedDiagnoses).

% Provides diagnosis based on sorted results by priority
diagnose_based_on_sorted([(Priority, Disease, Treatment)|_]) :-
    write('Based on your symptoms, you might have '), write(Disease),
    write(' (Priority: '), write(Priority), write('). Suggested treatment: '), write(Treatment), nl.

/*------------------------------*/
/* END OF MEDICAL EXPERT SYSTEM */
/*------------------------------*/