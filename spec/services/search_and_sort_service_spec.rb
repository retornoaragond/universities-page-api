# frozen_string_literal: true

require "rails_helper"

RSpec.describe SearchAndSortService, type: :service do
  let!(:university_1) { create(:university, name: "University of Costa Rica", location: "San José", website_url: "http://ucr.ac.cr") }
  let!(:university_2) { create(:university, name: "National University", location: "Heredia", website_url: "http://una.ac.cr") }
  let!(:university_3) { create(:university, name: "Técnologico of Costa Rica", location: "Cartago", website_url: "http://tec.ac.cr") }

  let(:scope) { University.all }
  let(:searchable_columns) { %w[name location website_url] }

  describe "#call" do
    context "when sorting" do
      it "sorts records in ascending order by a valid column" do
        params = { sort_by: "name", sort_order: "asc" }
        service = SearchAndSortService.new(scope, params, searchable_columns)

        result = service.call

        expect(result).to eq([university_2, university_3, university_1])
      end

      it "sorts records in descending order by a valid column" do
        params = { sort_by: "name", sort_order: "desc" }
        service = SearchAndSortService.new(scope, params, searchable_columns)

        result = service.call

        expect(result).to eq([university_1, university_3, university_2])
      end

      it "returns unsorted records when sort_by is invalid" do
        params = { sort_by: "invalid_column", sort_order: "asc" }
        service = SearchAndSortService.new(scope, params, searchable_columns)

        result = service.call

        expect(result).to contain_exactly(university_1, university_2, university_3)
      end

      it "returns unsorted records when sort_order is invalid" do
        params = { sort_by: "name", sort_order: "invalid_order" }
        service = SearchAndSortService.new(scope, params, searchable_columns)

        result = service.call

        expect(result).to contain_exactly(university_1, university_2, university_3)
      end

      it "returns unsorted records when both sort_by and sort_order are invalid" do
        params = { sort_by: "invalid_column", sort_order: "invalid_order" }
        service = SearchAndSortService.new(scope, params, searchable_columns)

        result = service.call

        expect(result).to contain_exactly(university_1, university_2, university_3)
      end
    end

    context "when searching and sorting" do
      it "filters and sorts the records" do
        params = { search: "University", sort_by: "location", sort_order: "asc" }
        service = SearchAndSortService.new(scope, params, searchable_columns)

        result = service.call

        expect(result).to eq([university_2, university_1])
      end
    end
  end
end
