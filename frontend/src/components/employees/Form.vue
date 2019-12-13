<template>
  <div>
    <form novalidate class="md-layout" @submit.prevent="validate">
      <md-card class="md-layout-item md-size-50 md-small-size-100">
        <md-card-header>
          <div class="md-title">{{ title }}</div>
        </md-card-header>
        <md-card-content>
          <div class="md-layout md-gutter">
            <div class="md-layout-item md-small-size-100">
              <md-field :class="getValidationClass('name')">
                <label for="name">name</label>
                <md-input name="name" id="name" autocomplete="given-name" v-model="form.name" :disabled="sending" />
                <span class="md-error" v-if="!$v.form.name.required">The name is required</span>
                <span class="md-error" v-else-if="!$v.form.name.minlength">Invalid name</span>
              </md-field>
            </div>
          </div>
          <div class="md-layout md-gutter">
            <div class="md-layout-item md-small-size-100">
              <md-field :class="getValidationClass('position_id')">
                <label for="position_id">position</label>
                <md-select name="position_id" id="position_id" v-model="form.position_id" md-dense :disabled="sending">
                  <md-option v-for="position in positions" :value="position.id"
                      v-bind:key="position.id">{{ position.name }}
                  </md-option>
                </md-select>
                <span class="md-error">The position is required</span>
              </md-field>
            </div>
            <div class="md-layout-item md-small-size-100">
              <md-field :class="getValidationClass('salary')">
                <label for="salary">salary</label>
                <span class="md-prefix">$</span>
                <md-input name="salary" id="salary" v-model="form.salary" :disabled="sending" />
                <span class="md-error" v-if="!$v.form.salary.required">The salary is required</span>
              </md-field>
            </div>
          </div>
          <md-progress-bar md-mode="indeterminate" v-if="sending" />

          <md-card-actions>
            <md-button type="submit" class="md-primary" :disabled="sending">
              {{ submit }}
            </md-button>
          </md-card-actions>

        </md-card-content>
      </md-card>
    </form>
  </div>
</template>

<script>
  import { validationMixin } from 'vuelidate'
  import {
    required,
    minLength
  } from 'vuelidate/lib/validators'

  export default {
    data: () => ({
      form: {
        name: '',
        salary: null,
        position_id: null
      },
      positions: [],
      sending: false
    }),
    props: {
      title: String,
      submit: String
    },
    mixins: [validationMixin],
    beforeMount: function() {
      if (this.employee) {
        this.form  = this.employee
      } else {
        this.$store.dispatch('get_employee_by_id', this.$route.params.id)
         .then((response) => this.form = response.data)
         .catch(err => { console.log(err); })
      }
      this.$store.dispatch('get_positions')
     .then((response) => this.positions = response.data)
     .catch(err => console.log(err))
    },
    validations: {
      form: {
        name: {
          required,
          minLength: minLength(3)
        },
        salary: {
          required
        },
        position_id: {
          required
        }
      }
    },
    methods: {
      getValidationClass (fieldName) {
        const field = this.$v.form[fieldName]

        if (field) {
          return {
            'md-invalid': field.$invalid && field.$dirty
          }
        }
      },
      clearForm () {
        this.$v.$reset()
        this.form.name = null
        this.form.salary = null
        this.form.position_id = null
      },
      save () {
        this.sending = true

        let employee = {
          id: this.$route.params.id,
          name: this.form.name,
          salary: this.form.salary,
          position_id: this.form.position_id,
        }
        
        this.$parent.submit(employee)
       .then((response) => this.$router.push('/employees/' + response.data.id))
       .catch(err => console.log(err))
      },
      validate () {
        this.$v.$touch()

        if (!this.$v.$invalid) {
          this.save()
        }
      }
    }
  }
</script>