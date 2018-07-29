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


    File.delete('form.pdf') if File.exist?('form.pdf')
    c1 = params['code1']
    c2 = params['code2']
    c3 = params['code3']
    c4 = params['code4']
    c5 = params['code5']

    code_arr = ["'#{c1}'","'#{c2}'","'#{c3}'","'#{c4}'","'#{c5}'"]

    code_arr_clean = code_arr.reject { |c| c == "''" }

    conn = PG.connect( dbname: 'hh_proj' )

    counter = 1

    conn.exec("SELECT * from school_form_stats where num in (#{code_arr_clean.join(',')})") do |result|
      result.each_with_index do |row, i|
        field_name_1 = "untitled#{counter}"
        field_name_2 = "untitled#{counter+1}"
        field_name_3 = "untitled#{counter+2}"

        counter += 3

        name, grade, num = row.values_at('name', 'grade', 'num')

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
