package com.Subscription;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.Customer.Customer;
import com.Customer.CustomerRepository;
import com.Topic.Topic;
import com.Topic.TopicRepository;
import com.Writer.Writer;
import com.Writer.WriterRepository;

@Service
@Transactional
public class SubscriptionService {

	private final SubscriptionRepository subscriptionRepository;
	private final CustomerRepository customerRepository;
	private final TopicRepository topicRepository;
	private final WriterRepository writerRepository;

	public SubscriptionService(SubscriptionRepository subscriptionRepository,
							   CustomerRepository customerRepository,
							   TopicRepository topicRepository,
							   WriterRepository writerRepository) {
		this.subscriptionRepository = subscriptionRepository;
		this.customerRepository = customerRepository;
		this.topicRepository = topicRepository;
		this.writerRepository = writerRepository;
	}

	public Subscription create(Subscription subscription) {
		if (subscription.getStartDate() == null) {
			subscription.setStartDate(LocalDateTime.now());
		}

		// Resolve relations if only ids are provided
		if (subscription.getCustomer() != null && subscription.getCustomer().getId() != null) {
			Customer c = customerRepository.findById(subscription.getCustomer().getId())
					.orElseThrow(() -> new RuntimeException("Customer not found"));
			subscription.setCustomer(c);
		}

		if (subscription.getTopic() != null && subscription.getTopic().getId() != null) {
			Topic t = topicRepository.findById(subscription.getTopic().getId())
					.orElseThrow(() -> new RuntimeException("Topic not found"));
			subscription.setTopic(t);
		}

		if (subscription.getWriter() != null && subscription.getWriter().getId() != null) {
			Writer w = writerRepository.findById(subscription.getWriter().getId())
					.orElseThrow(() -> new RuntimeException("Writer not found"));
			subscription.setWriter(w);
		}

		return subscriptionRepository.save(subscription);
	}

	public Subscription update(Long id, Subscription details) {
		Subscription subscription = subscriptionRepository.findById(id)
				.orElseThrow(() -> new RuntimeException("Subscription not found"));

		if (details.getStartDate() != null) subscription.setStartDate(details.getStartDate());
		if (details.getEndDate() != null) subscription.setEndDate(details.getEndDate());
		subscription.setActive(details.isActive());

		if (details.getCustomer() != null && details.getCustomer().getId() != null) {
			Customer c = customerRepository.findById(details.getCustomer().getId())
					.orElseThrow(() -> new RuntimeException("Customer not found"));
			subscription.setCustomer(c);
		}

		if (details.getTopic() != null && details.getTopic().getId() != null) {
			Topic t = topicRepository.findById(details.getTopic().getId())
					.orElseThrow(() -> new RuntimeException("Topic not found"));
			subscription.setTopic(t);
		}

		if (details.getWriter() != null && details.getWriter().getId() != null) {
			Writer w = writerRepository.findById(details.getWriter().getId())
					.orElseThrow(() -> new RuntimeException("Writer not found"));
			subscription.setWriter(w);
		}

		return subscriptionRepository.save(subscription);
	}

	public Subscription cancel(Long id) {
		Subscription subscription = subscriptionRepository.findById(id)
				.orElseThrow(() -> new RuntimeException("Subscription not found"));
		subscription.setActive(false);
		if (subscription.getEndDate() == null) subscription.setEndDate(LocalDateTime.now());
		return subscriptionRepository.save(subscription);
	}

	public Subscription getById(Long id) {
		return subscriptionRepository.findById(id).orElseThrow(() -> new RuntimeException("Subscription not found"));
	}

	public List<Subscription> findByCustomer(Long customerId) {
		Customer c = customerRepository.findById(customerId).orElseThrow(() -> new RuntimeException("Customer not found"));
		return subscriptionRepository.findByCustomerAndActive(c, true);
	}

	public List<Subscription> findByTopic(Long topicId) {
		Topic t = topicRepository.findById(topicId).orElseThrow(() -> new RuntimeException("Topic not found"));
		return subscriptionRepository.findByTopic(t);
	}

	public List<Subscription> findByWriter(Long writerId) {
		Writer w = writerRepository.findById(writerId).orElseThrow(() -> new RuntimeException("Writer not found"));
		return subscriptionRepository.findByWriter(w);
	}

	public List<Subscription> findAll() {
		return subscriptionRepository.findAll();
	}

	// Controller-compatible method names
	public Subscription createSubscription(Subscription subscription) {
		return create(subscription);
	}

	public Subscription updateSubscription(Long id, Subscription details) {
		return update(id, details);
	}

	public void cancelSubscription(Long id) {
		cancel(id);
	}

	public List<Subscription> getActiveSubscriptionsByCustomer(Customer customer) {
		return subscriptionRepository.findByCustomerAndActive(customer, true);
	}

	public List<Subscription> getSubscriptionsByTopic(Topic topic) {
		return subscriptionRepository.findByTopic(topic);
	}
}

