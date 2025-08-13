import { Handshake, PencilRuler, Truck, ShieldCheck, Star } from 'lucide-react';

const processSteps = [
  {
    icon: <Handshake className="h-10 w-10 text-primary" />,
    title: '1. Consultation & Requirement Gathering',
    description: "We start by understanding your vision, needs, and budget. Our experts will visit your site or connect with you virtually to discuss your requirements in detail.",
  },
  {
    icon: <PencilRuler className="h-10 w-10 text-primary" />,
    title: '2. Design & 3D Visualization',
    description: "Our designers create personalized 2D and 3D designs, allowing you to visualize your space before it's built. We offer live 3D sessions for a truly contactless experience.",
  },
  {
    icon: <Truck className="h-10 w-10 text-primary" />,
    title: '3. Manufacturing & Delivery',
    description: "Once the design is finalized, our state-of-the-art manufacturing unit gets to work. We ensure timely and safe delivery of all components to your doorstep.",
  },
  {
    icon: <ShieldCheck className="h-10 w-10 text-primary" />,
    title: '4. Installation & Handover',
    description: "Our professional installation team assembles everything with precision. We conduct a final quality check before handing over your brand new, dream interior.",
  },
  {
    icon: <Star className="h-10 w-10 text-primary" />,
    title: '5. Warranty & Support',
    description: "Your satisfaction is our priority. We provide a one-year warranty on our work and are always available for any post-installation support you may need.",
  },
];

export default function HowItWorksPage() {
  return (
    <div className="bg-background">
      <div className="container mx-auto px-4 py-16">
        <div className="text-center mb-16">
          <h1 className="text-4xl md:text-5xl font-bold">Our Process</h1>
          <p className="text-lg text-muted-foreground mt-2">A seamless journey from concept to completion.</p>
        </div>

        <div className="relative">
          {/* Timeline line */}
          <div className="absolute left-1/2 -translate-x-1/2 h-full w-0.5 bg-border hidden md:block"></div>

          <div className="space-y-16">
            {processSteps.map((step, index) => (
              <div key={index} className="flex flex-col md:flex-row items-center w-full">
                {/* Content Left */}
                <div className={`md:w-5/12 ${index % 2 === 0 ? 'md:order-1' : 'md:order-3 md:text-right'}`}>
                  <div className="p-6 border rounded-lg shadow-md bg-card">
                    <div className="flex items-center mb-2 md:hidden">
                      {step.icon}
                      <h2 className="text-2xl font-bold ml-4">{step.title}</h2>
                    </div>
                    <h2 className="text-2xl font-bold hidden md:block">{step.title}</h2>
                    <p className="mt-2 text-muted-foreground">{step.description}</p>
                  </div>
                </div>

                {/* Icon Middle */}
                <div className="md:w-2/12 md:order-2 flex justify-center">
                  <div className="z-10 bg-background p-2 rounded-full border-2 border-primary my-4 md:my-0">
                    {step.icon}
                  </div>
                </div>

                {/* Spacer Right */}
                <div className="md:w-5/12 md:order-3"></div>
              </div>
            ))}
          </div>
        </div>
      </div>
    </div>
  );
}
