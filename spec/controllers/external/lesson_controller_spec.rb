require 'rails_helper'

RSpec.describe External::LessonsController, type: :controller do
  describe '#get_student' do
    let(:student_user) { FactoryBot.create(:student_user) }
    let(:student) { FactoryBot.create(:student, student_user: student_user) }

    before do
      allow(controller).to receive(:current_student_user).and_return(student_user)
      allow(controller).to receive(:authenticate_student_user!).and_return(true)
      allow(controller).to receive(:get_student)
    end

    context 'when student is signed in' do
      it 'assigns the student data' do
        sign_in student_user
        controller.send(:get_student)
        expect(assigns(:student_data)).to eq(student_user.student)
        expect(controller.instance_variable_get(:@student_data)).to eq(student_user.student)
      end
    end

    context 'when student is not signed in' do
      it 'does not assign student data' do
        allow(controller).to receive(:current_student_user).and_return(nil)
        expect(controller.send(:get_student)).to be_nil
      end
    end
  end


  describe '#get_next_lesson' do
    context 'when there is a next lesson' do
      it 'sets @next_lesson to the next lesson' do
        lesson = FactoryBot.create(:lesson)
        event = FactoryBot.create(:event)
        controller.instance_variable_set(:@lesson, lesson)
        controller.instance_variable_set(:@event, event)

        next_lesson = FactoryBot.create(:lesson, id: lesson.id + 1, event: event)
        allow(Lesson).to receive(:find_by).and_return(next_lesson)

        controller.send(:get_next_lesson)

        expect(controller.instance_variable_get(:@next_lesson)).to eq(next_lesson)
      end
    end

    context 'when there is no next lesson' do
      it 'sets @next_lesson to the current lesson' do
        lesson = FactoryBot.create(:lesson)
        event = FactoryBot.create(:event)
        controller.instance_variable_set(:@lesson, lesson)
        controller.instance_variable_set(:@event, event)

        allow(Lesson).to receive(:find_by).and_return(nil)

        controller.send(:get_next_lesson)

        expect(controller.instance_variable_get(:@next_lesson)).to eq(lesson)
      end
    end
  end

  describe '#get_previous_lesson' do
    context 'when tere is a previous lesson' do
      it 'sets @previous_lesson to the previous lesson' do
        lesson = FactoryBot.create(:lesson)
        event = FactoryBot.create(:event)
        controller.instance_variable_set(:@lesson, lesson)
        controller.instance_variable_set(:@event, event)

        previous_lesson = FactoryBot.create(:lesson, id: lesson.id - 1, event: event)
        allow(Lesson).to receive(:find_by).and_return(previous_lesson)

        controller.send(:get_previous_lesson)

        expect(controller.instance_variable_get(:@previous_lesson)).to eq(previous_lesson)
      end
    end

    context 'when there is no previous lesson' do
      it 'sets @previous_lesson to the first lesson of the event' do
        lesson = FactoryBot.create(:lesson)
        event = FactoryBot.create(:event)
        controller.instance_variable_set(:@lesson, lesson)
        controller.instance_variable_set(:@event, event)

        allow(Lesson).to receive(:find_by).and_return(nil)

        first_lesson = FactoryBot.create(:lesson, event: event)
        allow(event).to receive_message_chain(:lessons, :first).and_return(first_lesson)

        controller.send(:get_previous_lesson)

        expect(controller.instance_variable_get(:@previous_lesson)).to eq(first_lesson)
      end
    end
  end

  describe '#is_first_lesson?' do
    context 'when the lesson is the first lesson of the event' do
      it 'returns true' do
        event = FactoryBot.create(:event)
        first_lesson = FactoryBot.create(:lesson, event: event)

        expect(controller.send(:is_first_lesson?, first_lesson)).to be_truthy
      end
    end

    context 'when the lesson is not the first lesson of the event' do
      it 'returns false' do
        event = FactoryBot.create(:event)
        first_lesson = FactoryBot.create(:lesson, event: event)
        second_lesson = FactoryBot.create(:lesson, event: event)

        expect(controller.send(:is_first_lesson?, second_lesson)).to be_falsey
      end
    end
  end

  describe '#is_last_lesson?' do
    context 'when the lesson is the first lesson of the event' do
      it 'returns true' do
        event = FactoryBot.create(:event)
        first_lesson = FactoryBot.create(:lesson, event: event)
        last_lesson = FactoryBot.create(:lesson, event: event)

        expect(controller.send(:is_last_lesson?, last_lesson)).to be_truthy
      end
    end

    context 'when the lesson is not the last lesson of the event' do
      it 'returns false' do
        event = FactoryBot.create(:event)
        first_lesson = FactoryBot.create(:lesson, event: event)
        second_lesson = FactoryBot.create(:lesson, event: event)
        last_lesson = FactoryBot.create(:lesson, event: event)

        expect(controller.send(:is_last_lesson?, first_lesson)).to be_falsey
        expect(controller.send(:is_last_lesson?, second_lesson)).to be_falsey
        expect(controller.send(:is_last_lesson?, last_lesson)).to be_truthy
      end
    end
  end

  describe '#student_has_watched' do
    let(:student_user) { FactoryBot.create(:student_user) }
    let(:student) { FactoryBot.create(:student, student_user: student_user) }
    let(:event) { FactoryBot.create(:event) }
    let(:lesson) { FactoryBot.create(:lesson, event: event) }
    let!(:student_lesson) { FactoryBot.create(:student_lesson, student: student, lesson: lesson) }

    context 'when student is signed in' do
      before do
        sign_in student_user
      end

      it 'returns true if the student has watched the lesson' do
        student_lesson = FactoryBot.create(:student_lesson, student: student, lesson: lesson)
        student_lesson.reload
        result = StudentLesson.exists?(student_id: student.id, lesson_id: lesson.id)
        expect(result).to be true
      end

      it 'returns false if the student has not watched the lesson' do
        new_lesson = FactoryBot.create(:lesson, event: event)
        expect(controller.student_has_watched).to be_falsey
      end
    end

    context 'when student is not signed in' do
      before do
        allow(controller).to receive(:get_student).and_return(nil)
      end

      it 'returns nil if the student is not signed in' do
        expect(controller.student_has_watched).to be_nil
      end
    end
  end

  describe '#check_lesson' do
    let(:student) { FactoryBot.create(:student) }
    let(:lesson) { FactoryBot.create(:lesson) }

    context 'when the lesson status is "progress"' do
      before do
        student_lessons_stub = double('student_lessons_stub', pluck: ['progress'])
        allow(StudentLesson).to receive(:where).and_return(student_lessons_stub)
      end

      it 'returns "progress"' do
        expect(controller.check_lesson).to eq('progress')
      end
    end

    context 'when the lesson status is "not started"' do
      before do
        student_lessons_stub = double('student_lessons_stub', pluck: ['not started'])
        allow(StudentLesson).to receive(:where).and_return(student_lessons_stub)
      end

      it 'returns "not started"' do
        expect(controller.check_lesson).to eq('not started')
      end
    end

    context 'when the lesson status is "finished"' do
      before do
        student_lessons_stub = double('student_lessons_stub', pluck: ['finished'])
        allow(StudentLesson).to receive(:where).and_return(student_lessons_stub)
      end

      it 'returns "finished"' do
        expect(controller.check_lesson).to eq('finished')
      end
    end
  end

  describe '#first_time_class' do
    context 'when the student has not watched any lesson before' do
      it 'inserts student lessons and redirects to the root' do
        event = FactoryBot.create(:event)

        student = create(:student)
        lesson1 = FactoryBot.create(:lesson, event: event)
        lesson2 = FactoryBot.create(:lesson, event: event)
        lesson3 = FactoryBot.create(:lesson, event: event)

        allow(subject).to receive(:get_student).and_return(true)
        allow(subject).to receive(:student_has_watched).and_return(false)
        allow(subject).to receive(:redirect_back)

        subject.instance_variable_set(:@student_data, student)

        subject.instance_variable_set(:@lesson_ids, [lesson1.id, lesson2.id, lesson3.id]) if subject.instance_variable_get(:@lesson_ids).nil?

        expect(subject).to receive(:redirect_back).with(fallback_location: lessons_index_path(slug_event: event.slug))

        subject.first_time_class(event)
      end
    end
  end


  describe 'PATCH #terminate_lesson' do
    let(:event) { FactoryBot.create(:event) }
    let(:student) { FactoryBot.create(:student) }
    let(:lesson) { FactoryBot.create(:lesson) }

    before do
      allow(controller).to receive(:get_student).and_return(student)
      allow(controller).to receive(:params).and_return({ lesson_id: lesson.id, slug_event: event.slug })
    end

    context 'when current lesson is in progress' do
      it 'marks the current lesson as finished and updates the status of the next lesson if it exists' do
        student_lesson = create(:student_lesson, student: student, lesson: lesson, status: 'progress')
        student_lesson.update(status: "finished")
        next_lesson = create(:lesson)
        student_lesson2 = create(:student_lesson, student: student, lesson: next_lesson, status: 'progress')

        patch :terminate_lesson, params: {slug_event: event.slug, lesson_id: lesson.id}

        student_lesson.reload
        next_lesson.reload
        student_lesson2.reload

        expect(student_lesson.status).to eq('finished')
        expect(student_lesson2.status).to eq('progress')
      end

      it 'redirects to the lesson URL' do
        expect(patch :terminate_lesson, params: {slug_event: event.slug, lesson_id: lesson.id}).to redirect_to(lesson_url(event.slug, lesson.id))
      end
    end

  end
end
