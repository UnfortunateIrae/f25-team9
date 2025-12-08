package com.Subscription;

import java.time.LocalDateTime;

import com.Customer.Customer;
import com.Topic.Topic;
import com.Writer.Writer;

import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotNull;

@Entity
@Table(name = "subscriptions")
public class Subscription {
   @Id
   @GeneratedValue(strategy = GenerationType.IDENTITY)
   private Long id;

   @NotNull
   private LocalDateTime startDate;

   private LocalDateTime endDate;

   @NotNull
   private boolean active = true;

   @ManyToOne(fetch = FetchType.LAZY)
   @JoinColumn(name = "customer_id")
   private Customer customer;

   @ManyToOne(fetch = FetchType.LAZY)
   @JoinColumn(name = "topic_id")
   private Topic topic;

   @ManyToOne(fetch = FetchType.LAZY)
   @JoinColumn(name = "writer_id")
   private Writer writer;

   public Subscription() { }

   public Long getId() { return id; }
   public void setId(Long id) { this.id = id; }

   public LocalDateTime getStartDate() { return startDate; }
   public void setStartDate(LocalDateTime startDate) { this.startDate = startDate; }

   public LocalDateTime getEndDate() { return endDate; }
   public void setEndDate(LocalDateTime endDate) { this.endDate = endDate; }

   public boolean isActive() { return active; }
   public void setActive(boolean active) { this.active = active; }

   public Customer getCustomer() { return customer; }
   public void setCustomer(Customer customer) { this.customer = customer; }

   public Topic getTopic() { return topic; }
   public void setTopic(Topic topic) { this.topic = topic; }

   public Writer getWriter() { return writer; }
   public void setWriter(Writer writer) { this.writer = writer; }
}

enum SubscriptionType {
   ONE_TIME,
   MONTHLY
}
