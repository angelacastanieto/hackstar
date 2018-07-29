# app.rb
require "sinatra"
require 'sinatra/activerecord'
require 'fillable-pdf'

class App < Sinatra::Base
  get "/" do
    erb :index
  end

  get "/pdf" do
    pdf = FillablePDF.new 'final_form.pdf'
    path = params['path']


    field_map = {
      0 => [1,2,3],
      1 => [4,5,6],
      2 => [7,8,9],
      3 => [10,11,12],
      4 => [13,14,15]
    }

    File.delete('form.pdf') if File.exist?('form.pdf')
    codes = params['codes']

    transformed_codes = []

    split_codes = codes.split(',')

    split_codes.each do |code|
      transformed_codes << "'#{code}'"
    end

    conn = PG.connect( dbname: 'hh_proj' )

    conn.exec("SELECT * from school_form_stats where num in (#{transformed_codes.join(',')})") do |result|
      result.each_with_index do |row|
        name, grade, num = row.values_at('name', 'grade', 'num')

        code_index = split_codes.find_index(num)

        field_name_1 = "untitled#{field_map[code_index][0]}"
        field_name_2 = "untitled#{field_map[code_index][1]}"
        field_name_3 = "untitled#{field_map[code_index][2]}"

        pdf.set_field(field_name_1.to_sym, grade)
        pdf.set_field(field_name_2.to_sym, name)
        pdf.set_field(field_name_3.to_sym, num)
      end
    end

    pdf.save_as('form.pdf')

    headers "Content-Disposition" => "attachment", "Content-Type" => "application/pdf"

    send_file(File.open('form.pdf'), :disposition => 'attachment', :filename => 'form.pdf')
  end
end
