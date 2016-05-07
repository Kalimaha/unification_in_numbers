class WelcomeController < ApplicationController

  def index

    # Custom colors for the various states.
    colors = {
        'Papal States'.to_sym => '#EFC050',
        'Duchy of Parma'.to_sym => '#D65076',
        'Kingdom of Sardinia'.to_sym => '#4B61D1',
        'Grand Duchy of Tuscany'.to_sym => '#7FCDCD',
        'Duchy of Modena and Reggio'.to_sym => '#D0DD3D',
        'Kingdom of Lombardy Venetia'.to_sym => '#009B77',
        'Kingdom of the Two Sicilies'.to_sym => '#BC243C'
    }

    # Budget chart.
    @data_chart_01 = []
    Budget.all.order(value: :desc).each_with_index { |b, i|
      @data_chart_01 << {
        name: b[:state],
        y: b[:value],
        color: colors[b[:state].to_sym],
        sliced: i == 0
      }
    }

    # Population chart.
    @data_chart_02 = []
    Population.all.order(value: :desc).each_with_index { |b, i|
      @data_chart_02 << {
          name: b[:state],
          y: b[:value],
          color: colors[b[:state].to_sym],
          sliced: i == 0
      }
    }

    # Taxes chart.
    @data_chart_03 = []
    total = 0
    states = 0
    Tax.all.order(taxes_per_person: :desc).each { |b|
      @data_chart_03 << {
          name: b[:state],
          y: b[:taxes_per_person],
          color: colors[b[:state].to_sym]
      }
      total += b[:taxes_per_person]
      states += 1
    }
    @average = (total / states).round(2)

    # PIL chart.
    @data_chart_04 = []
    tmp_1 = {name: 'Papal States', data: [], color: '#EFC050'}
    tmp_2 = {name: 'Kingdom of Sardinia', data: [], color: '#4B61D1'}
    tmp_3 = {name: 'Kingdom of Lombardy Venetia', data: [], color: '#009B77'}
    tmp_4 = {name: 'Kingdom of the Two Sicilies', data: [], color: '#BC243C'}
    Pil.group(:state, :year).order(state: :asc, year: :asc).average(:pil_per_person).each { |key, value|
      case key[0]
        when 'Papal States'
          tmp_1[:data] << [key[1], value.to_f.round(2)]
        when 'Kingdom of Sardinia'
          tmp_2[:data] << [key[1], value.to_f.round(2)]
        when 'Kingdom of Lombardy Venetia'
          tmp_3[:data] << [key[1], value.to_f.round(2)]
        when 'Kingdom of the Two Sicilies'
          tmp_4[:data] << [key[1], value.to_f.round(2)]
      end
    }
    @data_chart_04 << tmp_1
    @data_chart_04 << tmp_2
    @data_chart_04 << tmp_3
    @data_chart_04 << tmp_4

    # Heat Map.
    @data_chart_05 = []
    year = 0
    Pil.group(:state, :year).order(state: :asc, year: :asc).average(:pil_per_person).each { |key, value|
      if key[0] != nil && key[0] != 'Grand Duchy of Tuscany'
        tmp = []
        tmp << year
        year += 1
        year = 0 if year == 14
        case key[0]
          when 'Papal States'
            tmp << 0
          when 'Kingdom of Sardinia'
            tmp << 1
          when 'Kingdom of Lombardy Venetia'
            tmp << 2
          when 'Kingdom of the Two Sicilies'
            tmp << 3
          else
            puts key[0]
        end
        tmp << value.to_f.round(2)
        @data_chart_05 << tmp
      end
    }

  end

end