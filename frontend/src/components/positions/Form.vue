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
              <md-field>
                <label for="name">name</label>
                <md-input name="name" id="name" v-model="form.name" :disabled="sending" />
                <span class="md-error" v-if="!$v.form.name.required">The name is required</span>
                <span class="md-error" v-else-if="!$v.form.name.minlength">Invalid name</span>
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
        name: ''
      },
      positions: [],
      sending: false
    }),
    props: {
      title: String,
      submit: String,
      position: {}
    },
    mixins: [validationMixin],
    beforeMount: function() {
      if (this.position) {
        this.form.name = this.position.name
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
      },
      save () {
        this.sending = true

        let position = {
          id: this.$route.params.id,
          name: this.form.name
        }
        
        this.$parent.submit(position)
       .then((response) => this.$router.push('/positions/' + response.data.id))
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