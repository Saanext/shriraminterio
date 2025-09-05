
'use client';

import { useEffect, useState } from 'react';
import { Dialog, DialogContent, DialogTitle, DialogDescription } from '@/components/ui/dialog';
import { Carousel, CarouselContent, CarouselItem, CarouselNext, CarouselPrevious } from '@/components/ui/carousel';
import Image from 'next/image';
import { X } from 'lucide-react';
import type { CarouselApi } from "@/components/ui/carousel"

type WorkGalleryFullscreenProps = {
  images: { image: string; title: string; hint?: string }[];
  startIndex: number;
  onClose: () => void;
};

export function WorkGalleryFullscreen({ images, startIndex, onClose }: WorkGalleryFullscreenProps) {
  const [open, setOpen] = useState(true);
  const [api, setApi] = useState<CarouselApi>()
 
  useEffect(() => {
    if (!api) {
      return
    }
    api.scrollTo(startIndex, true)
  }, [api, startIndex])


  const handleClose = () => {
    setOpen(false);
    onClose();
  };

  return (
    <Dialog open={open} onOpenChange={handleClose}>
      <DialogContent className="bg-black/90 border-none p-0 max-w-none w-screen h-screen flex items-center justify-center">
        <DialogTitle className="sr-only">Work Gallery</DialogTitle>
        <DialogDescription className="sr-only">
          A fullscreen carousel of work gallery images. Use the next and previous buttons to navigate.
        </DialogDescription>
        <button
          onClick={handleClose}
          className="absolute top-4 right-4 z-50 text-white hover:text-primary transition-colors"
        >
          <X className="w-8 h-8" />
          <span className="sr-only">Close</span>
        </button>
        <div className="w-full h-full flex items-center justify-center">
            <Carousel setApi={setApi} className="w-full max-w-6xl h-full flex items-center">
              <CarouselContent>
                {images.map((item, index) => (
                  <CarouselItem key={index} className="flex items-center justify-center">
                    <div className="relative w-full h-[80vh]">
                        <Image
                            src={item.image}
                            alt={item.title}
                            layout="fill"
                            objectFit="contain"
                            data-ai-hint={item.hint}
                        />
                         <div className="absolute bottom-4 left-1/2 -translate-x-1/2 p-2 rounded-md bg-black/50 text-white text-center">
                            <h3 className="text-lg font-bold">{item.title}</h3>
                        </div>
                    </div>
                  </CarouselItem>
                ))}
              </CarouselContent>
              <CarouselPrevious className="left-4 text-white bg-black/50 hover:bg-primary border-white/50 hover:border-primary" />
              <CarouselNext className="right-4 text-white bg-black/50 hover:bg-primary border-white/50 hover:border-primary" />
            </Carousel>
        </div>
      </DialogContent>
    </Dialog>
  );
}
